class GameSettings < ActiveRecord::Base

  @@settings = Hash.new
  @@caching = nil

  def self.set(key, value)
    GameSettings.use_cache? if @@caching.nil?
    if !@@caching || @@settings.nil?  then
      @@settings = Hash.new
    end
    return false if key.nil? || value.nil? || @@settings.include?(key.to_s)
    value = "__b__:" + value.to_s if value == true || value == false
    value = "__i__:" + value.to_s if value.is_a?Integer
    GameSettings.create(key: key.to_s, value: value.to_s)
    @@settings.append_merge!(key.to_s, value.to_s) if @@caching
    return true
  end

  def self.get(key)
    GameSettings.use_cache? if @@caching.nil?
    return "" if key.nil?
    if !@@caching || @@settings.nil?  then
      @@settings = Hash.new
    end
    if @@settings.include?(key.to_s) then
      return @@settings[key.to_s]
    else
      setting = GameSettings.where(key: key.to_s)
    end
    return "" if setting.nil? || setting.empty?
      out =  setting.first.value
      out = (setting.first.value[6..-1] == "true") if setting.first.value[0..5] == "__b__:"
      out =  setting.first.value[6..-1].to_i if setting.first.value[0..5] == "__i__:"
      @@settings.append_merge!(key, out) if @@caching
    return out
  end

  def set(key, value)
    GameSettings.set(key, value)
  end

  def get(key)
    GameSettings.get(key)
  end

  def self.use_cache?
    cc = GameSettings.where(key: "caching?")
    @@caching = !cc.empty? && (cc.first.value == "__b__:true")
  end

end