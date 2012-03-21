module UtilityHelper
  def self.to_boolean(value, nil_value = nil)
    value.downcase! if value.class == String
    case value
      when "no","false",false, "0", 0
        false
      when "yes","true",true, "1", 1
        true
      when nil
        nil_value
      else
        !!value
      end
  end
end
