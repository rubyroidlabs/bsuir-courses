require "telegram/bot"
require "redis"
require "json"
require "date"
require_relative "commands/command"
require_relative "commands/start"
require_relative "commands/semester"
require_relative "commands/subject"
require_relative "commands/status"
require_relative "commands/reset"

BOT_TOKEN = "262714580:AAFCpXitEnqHsRlCR888wq6t5GkdB9Fpnkc"
REDIS_HOST = { host: "redis-18148.c10.us-east-1-3.ec2.cloud.redislabs.com",
               port: "18148",
               password: "111111111111" }
