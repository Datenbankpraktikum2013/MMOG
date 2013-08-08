class GameSettings < ActiveRecord::Base

  def self.set(key, value)
    return false if key.nil? || value.nil?
    value = "__i__:" + value.to_s if value.is_a?Integer
    GameSettings.create(key: key.to_s, value: value.to_s)
    return true
  end

  def self.get(key)
    return "" if key.nil?
    setting = GameSettings.where(key: key.to_s)
    return "" if setting.nil? || setting.empty?
    return setting.first.value[6..-1].to_i if setting.first.value[0..5] == "__i__:"
    return setting.first.value
  end

  def set(key, value)
    GameSettings.set(key, value)
  end

  def get(key)
    GameSettings.get(key)
  end

end
