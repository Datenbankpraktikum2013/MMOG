class GameSettings < ActiveRecord::Base

  def self.set(key, value)
    return false if key.nil? || value.nil?
    GameSettings.create(key: key.to_s, value: value.to_s)
    return true
  end

  def self.get(key)
    return "" if key.nil?
    setting = GameSettings.where(key: key.to_s)
    return "" if setting.nil? || setting.empty?
    return setting.first.value
  end

  def set(key, value)
    GameSettings.set(key, value)
  end

  def get(key)
    GameSettings.get(key)
  end

end
