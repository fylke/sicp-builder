#!/usr/bin/env ruby
# Splits the plain-text rendering of the book (texi2any --plaintext) into one file per
# exercise: <outdir>/chapter-N/exercise-N.MM.txt. Usage: extract-exercises.rb book.txt outdir
require 'fileutils'

book, outdir = ARGV
abort "usage: #{$0} book.txt outdir" unless book && outdir

lines = File.readlines(book, chomp: true)
START = /\A {5}\*Exercise (\d+)\.(\d+):\* ?(.*)\z/
FOOTNOTES = /\A\s*-{10} Footnotes -{10}\z/
UNDERLINE = /\A[*=\-.]{4,}\z/

starts = lines.each_index.select { |i| lines[i] =~ START }

# A node heading is a numbered column-0 title line followed by an underline. Unnumbered
# sub-headings are not nodes, and footnotes are collected at the end of the node.
def heading_at?(lines, i)
  i > 0 && lines[i] =~ UNDERLINE && lines[i - 1] =~ /\A\d+(\.\d+)*\s+\S/
end

# Footnote text for the node containing line `from`, keyed by marker number.
def footnotes_after(lines, from)
  i = from
  while i < lines.size
    return {} if heading_at?(lines, i + 1)
    break if lines[i] =~ FOOTNOTES
    i += 1
  end
  return {} if i >= lines.size

  notes = {}
  current = nil
  i += 1
  while i < lines.size && !heading_at?(lines, i + 1)
    if lines[i] =~ /\A {3}\((\d+)\) (.*)\z/
      current = Regexp.last_match(1).to_i
      notes[current] = [Regexp.last_match(2)]
    elsif current
      notes[current] << lines[i]
    end
    i += 1
  end
  notes.transform_values { |v| v.join("\n").strip }
end

count = 0
starts.each do |s|
  chapter, number = lines[s][START, 1], lines[s][START, 2]
  body = [lines[s]]
  i = s + 1
  # The exercise is a quotation: every line stays indented by at least five spaces.
  while i < lines.size && (lines[i].empty? || lines[i].start_with?('     ')) &&
        lines[i] !~ START && lines[i] !~ FOOTNOTES
    body << lines[i]
    i += 1
  end
  body.pop while body.last.to_s.strip.empty?
  text = body.map { |l| l.sub(/\A {5}/, '') }.join("\n")

  markers = text.scan(/\((\d+)\)/).flatten.map(&:to_i).uniq
  unless markers.empty?
    notes = footnotes_after(lines, i)
    found = markers.select { |m| notes[m] }
    unless found.empty?
      text += "\n\n---------- Footnotes ----------\n\n" +
              found.map { |m| "(#{m}) #{notes[m]}" }.join("\n\n")
    end
  end

  # Info cross-reference markup is meaningless in a standalone file:
  # "*note Exercise 1.2::" and "*note 1.1.7: Sec.1.1.7." both become the visible label.
  text.gsub!(/\*note(\s+)(?:([^:]+?):\s+[^:]+?\.(?![A-Za-z0-9])|(.+?)::)/m) do
    label = Regexp.last_match(2) || Regexp.last_match(3)
    Regexp.last_match(1).include?("\n") ? "\n#{label}" : label
  end
  text.gsub!(/ +$/, '')

  dir = File.join(outdir, "chapter-#{chapter}")
  FileUtils.mkdir_p(dir)
  File.write(File.join(dir, format('exercise-%s.%02d.txt', chapter, number.to_i)),
             text.sub(/\A\*Exercise ([\d.]+):\*/, 'Exercise \1:') + "\n")
  count += 1
end

abort "expected 356 exercises, found #{count}" unless count == 356
puts "Wrote #{count} exercises to #{outdir}"
