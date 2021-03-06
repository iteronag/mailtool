class EmailAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "must be in valid format") if record.errors[attribute].blank?
    end
  end
end

# class EmailAddressValidator < ActiveModel::Validator
#   EMAIL_ADDRESS_QTEXT           = Regexp.new '[^\\x0d\\x22\\x5c\\x80-\\xff]', nil, 'n'
#   EMAIL_ADDRESS_DTEXT           = Regexp.new '[^\\x0d\\x5b-\\x5d\\x80-\\xff]', nil, 'n'
#   EMAIL_ADDRESS_ATOM            = Regexp.new '[^\\x00-\\x20\\x22\\x28\\x29\\x2c\\x2e\\x3a-\\x3c\\x3e\\x40\\x5b-\\x5d\\x7f-\\xff]+', nil, 'n'
#   EMAIL_ADDRESS_QUOTED_PAIR     = Regexp.new '\\x5c[\\x00-\\x7f]', nil, 'n'
#   EMAIL_ADDRESS_DOMAIN_LITERAL  = Regexp.new "\\x5b(?:#{EMAIL_ADDRESS_DTEXT}|#{EMAIL_ADDRESS_QUOTED_PAIR})*\\x5d", nil, 'n'
#   EMAIL_ADDRESS_QUOTED_STRING   = Regexp.new "\\x22(?:#{EMAIL_ADDRESS_QTEXT}|#{EMAIL_ADDRESS_QUOTED_PAIR})*\\x22", nil, 'n'
#   EMAIL_ADDRESS_DOMAIN_REF      = EMAIL_ADDRESS_ATOM
#   EMAIL_ADDRESS_SUB_DOMAIN      = "(?:#{EMAIL_ADDRESS_DOMAIN_REF}|#{EMAIL_ADDRESS_DOMAIN_LITERAL})"
#   EMAIL_ADDRESS_WORD            = "(?:#{EMAIL_ADDRESS_ATOM}|#{EMAIL_ADDRESS_QUOTED_STRING})"
#   EMAIL_ADDRESS_DOMAIN          = "#{EMAIL_ADDRESS_SUB_DOMAIN}(?:\\x2e#{EMAIL_ADDRESS_SUB_DOMAIN})*"
#   EMAIL_ADDRESS_LOCAL_PART      = "#{EMAIL_ADDRESS_WORD}(?:\\x2e#{EMAIL_ADDRESS_WORD})*"
#   EMAIL_ADDRESS_SPEC            = "#{EMAIL_ADDRESS_LOCAL_PART}\\x40#{EMAIL_ADDRESS_DOMAIN}"
#   EMAIL_ADDRESS_PATTERN         = Regexp.new "#{EMAIL_ADDRESS_SPEC}", nil, 'n'
#   EMAIL_ADDRESS_EXACT_PATTERN   = Regexp.new "\\A#{EMAIL_ADDRESS_SPEC}\\z", nil, 'n'

#   def validate(record)
#     unless record.email =~ EMAIL_ADDRESS_EXACT_PATTERN
#       record.errors[:email] << 'is invalid'
#     end
#   end
# end