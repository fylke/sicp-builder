#!/usr/bin/env ruby
# Converts the exercises in the Texinfo source of the book to Racket source files, one per
# exercise: <outdir>/chapter-N/exercise-N.MM.rkt. The statement is a Markdown comment at
# the top, followed by room for the solution.
# Usage: extract-exercises.rb sicp-pocket.texi outdir [testsdir]
# With testsdir, the header comment of the exercise's test (the names the solution must
# provide) is copied into the file.
#
# Only the Texinfo constructs that occur in the exercises are supported; anything else
# aborts the run instead of silently producing wrong output.
require 'fileutils'

EXPECTED = 356
MARKER = /\A@strong\{@anchor\{Exercise (\d+)\.(\d+)\}Exercise \d+\.\d+:\}\s*(.*)\z/

ACCENTS = {
  "'" => { 'a' => 'á', 'e' => 'é', 'i' => 'í', 'o' => 'ó', 'u' => 'ú', 'y' => 'ý',
           'A' => 'Á', 'E' => 'É', 'I' => 'Í', 'O' => 'Ó', 'U' => 'Ú' },
  '`' => { 'a' => 'à', 'e' => 'è', 'i' => 'ì', 'o' => 'ò', 'u' => 'ù' },
  '"' => { 'a' => 'ä', 'e' => 'ë', 'i' => 'ï', 'o' => 'ö', 'u' => 'ü',
           'A' => 'Ä', 'O' => 'Ö', 'U' => 'Ü' },
  '^' => { 'a' => 'â', 'e' => 'ê', 'i' => 'î', 'o' => 'ô', 'u' => 'û' },
  '~' => { 'a' => 'ã', 'n' => 'ñ', 'o' => 'õ' },
  ',' => { 'c' => 'ç', 'C' => 'Ç' }
}.freeze

# Index of the brace matching the one at s[i], skipping @{ and @} escapes.
def matching_brace(s, i)
  depth = 0
  j = i
  while j < s.size
    case s[j]
    when '@' then j += 1
    when '{' then depth += 1
    when '}'
      depth -= 1
      return j if depth.zero?
    end
    j += 1
  end
  raise "unbalanced brace in: #{s[i, 80].inspect}"
end

# Replaces each @footnote{...} by a placeholder, so footnotes that span blank lines do not
# get cut up by the paragraph splitting. Returns the new text and the footnote bodies.
def pull_footnotes(text)
  notes = []
  out = +''
  i = 0
  while (k = text.index('@footnote{', i))
    close = matching_brace(text, k + 9)
    notes << text[(k + 10)...close]
    out << text[i...k] << "\u0001#{notes.size}\u0001"
    i = close + 1
  end
  [out << text[i..], notes]
end

class Converter
  def initialize(lines)
    @l = lines
    @i = 0
    @float = false
    @ended = false
  end

  # Converts the lines up to `@end <end_name>` (consumed), or to the end of the input.
  # With stop_at_item it also stops, without consuming, at the next @item.
  def parse(end_name = nil, stop_at_item: false)
    out = []
    para = []
    flush = lambda do
      unless para.empty?
        out << paragraph(para.join("\n")) << ''
        para.clear
      end
    end

    while @i < @l.size
      line = @l[@i]
      if end_name && line =~ /\A@end #{end_name}\b/
        @i += 1
        @ended = true
        return trim(out)
      end
      if stop_at_item && line =~ /\A@item\b/
        @ended = false
        return trim(out)
      end

      directive = line[/\A@([a-z]+)\b/, 1]
      case directive
      when nil
        if line =~ /\A\s*\z/
          flush.call
        else
          para << line
        end
        @i += 1
      when 'lisp', 'example'
        flush.call
        out.concat(code_block(directive))
      when 'ifinfo'
        flush.call
        @i += 1
        # In a float the ASCII art is the only version that works outside TeX.
        if @float
          out.concat(parse('ifinfo')) << ''
        else
          skip('ifinfo')
        end
      when 'iftex'
        flush.call
        @i += 1
        skip('iftex')
      when 'tex'
        flush.call
        out.concat(tex_block)
      when 'enumerate', 'itemize'
        flush.call
        out.concat(list)
      when 'quotation'
        flush.call
        @i += 1
        inner = parse('quotation')
        out.concat(inner.map { |x| x.empty? ? '>' : "> #{x}" }) << ''
      when 'float'
        flush.call
        @i += 1
        saved = @float
        @float = true
        out.concat(parse('float')) << ''
        @float = saved
      when 'noindent', 'c'
        @i += 1
      when 'anchor'
        # A line that is only an anchor marks a target; inline anchors are handled below.
        para << line unless line =~ /\A@anchor\{[^}]*\}\s*\z/
        @i += 1
      when 'item', 'end'
        raise "unexpected #{line.inspect}"
      else
        para << line
        @i += 1
      end
    end
    flush.call
    @ended = false
    trim(out)
  end

  private

  def trim(lines)
    lines.shift while lines.first == ''
    lines.pop while lines.last == ''
    lines
  end

  def skip(name)
    @i += 1 until @l[@i] =~ /\A@end #{name}\b/
    @i += 1
  end

  def raw_block(name)
    @i += 1
    lines = []
    until @l[@i] =~ /\A@end #{name}\b/
      raise "unterminated @#{name}" if @l[@i].nil?

      lines << @l[@i]
      @i += 1
    end
    @i += 1
    lines
  end

  def code_block(kind)
    lines = inline(raw_block(kind).join("\n"), :code).split("\n", -1)
    ["```#{kind == 'lisp' ? 'scheme' : ''}", *trim(lines), '```', '']
  end

  # Plain TeX display math. Blank lines would end the math in Markdown renderers.
  def tex_block
    body = raw_block('tex').map { |l| l.sub(/\s*%.*\z/, '') }
    body = body.join("\n").gsub(/\\\[|\\\]/, '')
    # KaTeX and MathJax render aligned, not the LaTeX eqnarray.
    body = body.gsub(/\\(begin|end)\{eqnarray\*?\}/, '\\\\\\1{aligned}').gsub('&=&', '&=')
    body = body.lines.map(&:rstrip).reject(&:empty?)
    return [] if body.empty?

    ['$$', *body, '$$', '']
  end

  def list
    @l[@i] =~ /\A@(enumerate|itemize)\s*(.*)\z/
    kind = Regexp.last_match(1)
    arg = Regexp.last_match(2).strip
    counter = arg.empty? ? '1' : arg
    @i += 1
    items = []
    loop do
      line = @l[@i]
      raise "unterminated @#{kind}" if line.nil?

      if line =~ /\A@end #{kind}\b/
        @i += 1
        break
      elsif line =~ /\A@item\b(.*)\z/
        rest = Regexp.last_match(1).strip
        if rest.empty?
          @i += 1
        else
          @l[@i] = rest
        end
        items << parse(kind, stop_at_item: true)
        break if @ended
      elsif line =~ /\A\s*\z/ || line =~ /\A@noindent\b/
        @i += 1
      else
        raise "unexpected #{line.inspect} in @#{kind}"
      end
    end

    out = []
    items.each do |body|
      marker =
        if kind == 'itemize' then '- '
        elsif counter =~ /\A\d+\z/ then "#{counter}. "
        else "- (#{counter}) "
        end
      counter = counter.succ if kind == 'enumerate'
      pad = ' ' * marker.size
      body.each_with_index do |l, n|
        out << (n.zero? ? marker + l : (l.empty? ? l : pad + l))
      end
      out << ''
    end
    out
  end

  def paragraph(text)
    s = inline(text, :prose).strip
    # A wrapped line that looks like a list or heading would change the meaning.
    s.gsub(/^([-+>#]|\d+[.)])(?= )/) { "\\#{Regexp.last_match(1)}" }
  end

  def typography(t)
    t.gsub('---', '—').gsub('--', '–').gsub('``', '“').gsub("''", '”')
     .gsub('`', '‘').gsub("'", '’')
     .gsub(/([\\*_<$\[\]])/) { "\\#{Regexp.last_match(1)}" }
  end

  # mode is :prose or :code (verbatim: no typography, no Markdown escaping).
  def inline(s, mode)
    out = +''
    buf = +''
    flush = lambda do
      out << (mode == :prose ? typography(buf) : buf)
      buf = +''
    end
    i = 0
    while i < s.size
      c = s[i]
      if c == "\u0001"
        j = s.index("\u0001", i + 1)
        flush.call
        out << "[^#{s[(i + 1)...j]}]"
        i = j + 1
      elsif c != '@'
        buf << c
        i += 1
      else
        n = s[i + 1]
        if n =~ /[@{}]/
          flush.call
          out << n
          i += 2
        elsif n == '-'
          i += 2
        elsif n == '*'
          flush.call
          out << "\\\n"
          i += 2
        elsif n =~ /[ \t\n]/
          buf << ' '
          i += 2
        elsif n =~ /[.!?]/
          buf << n
          i += 2
        elsif n == ':'
          i += 2
        elsif ACCENTS.key?(n) && s[i + 2] =~ /[A-Za-z]/
          flush.call
          out << (ACCENTS[n][s[i + 2]] || raise("unknown accent @#{n}#{s[i + 2]}"))
          i += 3
        elsif n =~ /[a-zA-Z]/
          name = s[(i + 1)..][/\A[a-zA-Z]+/]
          j = i + 1 + name.size
          if s[j] == '{'
            close = matching_brace(s, j)
            arg = s[(j + 1)...close]
            i = close + 1
          else
            arg = nil
            i = j
          end
          flush.call
          out << command(name, arg, mode)
        else
          raise "unsupported escape @#{n} in #{s[i, 40].inspect}"
        end
      end
    end
    flush.call
    out
  end

  def command(name, arg, mode)
    code = mode == :code
    raise "@#{name} needs an argument" if arg.nil? && name != 'dots'

    case name
    when 'code', 'samp', 'file', 't', 'kbd'
      inner = inline(arg, :code)
      return inner if code

      inner.include?('`') ? "`` #{inner} ``" : "`#{inner}`"
    when 'math'
      tex = arg.gsub(/@([@{}])/, '\1').gsub(/\s+/, ' ').strip
      code ? tex : "$#{tex}$"
    when 'var', 'i', 'emph', 'cite', 'newterm', 'dfn'
      inner = inline(arg, mode)
      code || inner.empty? ? inner : "*#{inner}*"
    when 'strong', 'b'
      inner = inline(arg, mode)
      code || inner.empty? ? inner : "**#{inner}**"
    when 'r', 'w', 'sc', 'abbr' then inline(arg.split(',').first, mode)
    when 'dots' then code ? '...' : '…'
    when 'bullet' then '•'
    when 'anchor' then ''
    when 'ref', 'xref', 'pxref'
      node, _, label = arg.split(',', 3).map(&:strip)
      label = node if label.nil? || label.empty?
      if node =~ /\AExercise (\d+)\.(\d+)\z/
        chapter = Regexp.last_match(1)
        "[#{label}](../chapter-#{chapter}/exercise-" \
          "#{chapter}.#{format('%02d', Regexp.last_match(2).to_i)}.rkt)"
      else
        typography(label)
      end
    else
      raise "unsupported command @#{name}"
    end
  end
end

texi, outdir, testsdir = ARGV
abort "usage: #{$PROGRAM_NAME} sicp-pocket.texi outdir [testsdir]" unless texi && outdir

src = File.readlines(texi, chomp: true)
count = 0
seen = {}

src.each_index do |s|
  next unless src[s] =~ MARKER

  chapter = Regexp.last_match(1)
  number = Regexp.last_match(2)
  body = [Regexp.last_match(3)]
  depth = 0
  (s + 1...src.size).each do |i|
    l = src[i]
    break if l =~ MARKER

    depth += 1 if l =~ /\A@quotation\b/
    if l =~ /\A@end quotation\b/
      break if depth.zero?

      depth -= 1
    end
    body << l
  end
  # Two exercises can share a quotation; the first one then ends in a stray @noindent.
  body.pop while body.last.to_s.strip.empty? || body.last == '@noindent'

  # Figures the exercise refers to sit in their own quotation after it.
  body.join("\n").scan(/@ref\{(Figure \d+\.\d+)\}/).flatten.uniq.each do |fig|
    start = src.index { |l| l.start_with?("@strong{@anchor{#{fig}}") }
    next unless start && src[start - 1] == '@quotation' && !body.include?(src[start])

    body << ''
    (start...src.size).each do |i|
      break if src[i] =~ /\A@end quotation\b/

      body << src[i]
    end
  end

  text, notes = pull_footnotes(body.join("\n"))
  md = Converter.new(text.split("\n", -1)).parse
  md << '' unless notes.empty?
  notes.each_with_index do |raw, k|
    note = Converter.new(raw.split("\n", -1)).parse
    md << "[^#{k + 1}]: #{note.first}"
    note.drop(1).each { |l| md << (l.empty? ? l : "    #{l}") }
    md << ''
  end

  id = "#{chapter}.#{number}"
  raise "duplicate exercise #{id}" if seen[id]

  seen[id] = true
  dir = File.join(outdir, "chapter-#{chapter}")
  FileUtils.mkdir_p(dir)
  name = format('exercise-%s.%02d', chapter, number.to_i)
  test = testsdir && File.join(testsdir, "chapter-#{chapter}", "#{name}.test.rkt")
  hint = []
  if test && File.exist?(test)
    # The first block of comment lines in the test says what the solution must provide.
    hint = File.readlines(test, chomp: true).drop(2).drop_while { |l| !l.start_with?(';;') }
               .take_while { |l| l.start_with?(';;') }
  end

  comment = md.join("\n").strip.lines.map { |l| l.strip.empty? ? ';;' : ";; #{l.rstrip}" }
  # The heading is "Exercise N.M" in Markdown; in the source file it is the first line.
  out = ['#lang sicp', ";; Exercise #{id}", ';;', *comment, '']
  if hint.empty?
    out << ';; No automatic test for this exercise.'
  else
    out << ";; Test: raco test tests/chapter-#{chapter}/#{name}.test.rkt"
    out.concat(hint)
  end
  out << '' << ''
  File.write(File.join(dir, "#{name}.rkt"), out.join("\n"))
  count += 1
end

abort "expected #{EXPECTED} exercises, found #{count}" unless count == EXPECTED
puts "Wrote #{count} exercises to #{outdir}"
