# помечает нужные версии
Dir['../lib/*.rb'].each { |f| require_relative f }

class VersionFilter
  def initialize(versions)
    @versions = {}
    versions.each { |v| @versions[v] = false }
  end

  def fetch(condition)
    # расставляем true false в зависимости подходит ли нам данная версия
    values = @versions.map { |key, _value| _value = Condition.new(condition).suitable?(key) }
    keys = @versions.map { |key, _value| key }
    values.each_with_index { |v, i| @versions[keys[i]] = v }
    @versions
  end
end
