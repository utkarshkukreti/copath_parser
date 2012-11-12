module CopathParser
  module Parsers
    class Prostrate < Parslet::Parser
      def self.parse_records(records)
        ret = []
        records.split(/\n\s*\n/).each do |record|
          parsed = new.parse record
          date = parsed[0][:date]
          case_number = parsed[0][:case_number]
          fmp = parsed[0][:fmp]
          i = 1
          parsed[1..-1].each do |addition|
            addition = addition[:addition]
            primary = addition[:first_number]
            secondary = addition[:second_number]
            sum = addition[:sum]
            block = i
            ret << [date, case_number, block, fmp, primary, secondary, sum].map(&:to_s).map(&:strip)
            i += 1
          end
        end
        ret
      end

      def self.parse_to_csv(records)
        CSV.generate do |csv|
          parse_records(records).each do |record|
            csv << record
          end
        end
      end

      root(:record)

      # Helpers
      rule(:sp) { match('\s') }
      rule(:sp?) { sp.repeat }
      rule(:word) { (sp.absent? >> any).repeat(1) >> sp? }
      rule(:number) { match['0-9'].repeat(1) >> sp? }
      rule(:eq) { str('=') >> sp? }
      rule(:plus) { str('+') >> sp? }
      rule(:f) { number.as(:first_number) }
      rule(:s) { number.as(:second_number) }
      rule(:sum) { number.as(:sum) }
      rule(:minus) { str('-') >> sp? }
      rule(:ob) { str('[') >> sp? }
      rule(:cb) { str(']') >> sp? }
      rule(:op) { str('(') >> sp? }
      rule(:cp) { str(')') >> sp? }

      rule(:addition) do
        f >> plus >> s >> eq >> sum |
        sum >> eq >> f >> plus >> s |
        f >> plus >> s >> minus >> sum |
        sum >> ob >> f >> plus >> s >> cb |
        f >> plus >> s >> (sum.absent? >> any).repeat >> sum |
        sum >> op >> f >> plus >> s >> cp
      end

      rule(:record) do
        word.as(:date) >>
        word.as(:case_number) >>
        word.as(:fmp) >>
        ((addition.absent? >> any).repeat >> addition.as(:addition)).repeat >>
        any.repeat
      end
    end
  end
end
