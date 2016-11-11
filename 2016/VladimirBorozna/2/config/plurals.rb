require "i18n/backend/pluralization"

russian_rule = lambda do |n|
  if n.zero?
    :zero
  elsif ((n % 10) == 1) && ((n % 100 != 11))
    :one
  elsif [2, 3, 4].include?(n % 10) && ![12, 13, 14].include?(n % 100)
    :few
  elsif (n % 10).zero? ||
        ![5, 6, 7, 8, 9].include?(n % 10) ||
        ![11, 12, 13, 14].include?(n % 100)
    :many
  end
end
keys = [:zero, :one, :few, :many]
plural = { i18n: { plural: { keys: keys, rule: russian_rule } } }

I18n::Backend::Simple.send(:include, I18n::Backend::Pluralization)
I18n.backend.store_translations(:ru, plural, escape: false)
