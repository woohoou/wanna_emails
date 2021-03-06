# encoding: utf-8
# Execute with: 
# rake olx:post_messages["Asurela Santiago Posts",Olx,"http://www.olx.cl/servicios-cat-191",1-2,false]

require "capybara"
require "capybara/dsl"
begin
  require 'capybara-webkit'
rescue LoadError => e
  
end

namespace :outlook_accounts do

  desc "Generate data dummy for services"
  task :create, [:n,:language] => :environment do |t, args|
    args.with_defaults n: 50
    args.with_defaults language: 'cl'

    logger = Logger.new("log/accounts/outlook_accounts.log")
    logger.info "=============================== Run #{DateTime.now.to_s}"

    Capybara.app_host = args[:url]
    Capybara.default_wait_time = 10
    Capybara.current_driver = :selenium

    include Capybara::DSL

    agent = TorPrivoxy::Agent.new host: ENV['TOR_HOST'], password: ENV['TOR_PASSWORD'], privoxy_port: ENV['TOR_PRIVOXY_PORT'], control_port: ENV['TOR_CONTROL_PORT'], capybara: true do |agent|
      logger.info "New IP is #{agent.ip}"
    end

    (0...args[:n].to_i).each_with_index do |n,index|
      begin
        if page.driver.browser.respond_to?(:clear_cookies)
          page.driver.browser.clear_cookies
        elsif page.driver.browser.respond_to?(:manage) and page.driver.browser.manage.respond_to?(:delete_all_cookies)
          page.driver.browser.manage.delete_all_cookies
        else
          raise "Don't know how to clear cookies. Weird driver?"
        end
        
        agent.switch_circuit
        visit "https://outlook.com"
        click_link 'Sign up now'

        sender = Sender.new(generate: :MX, sender_entity: SenderEntity.find_by(name: 'Outlook'))

        fill_in 'FirstName', with: sender.name.split(' ').first
        fill_in 'LastName', with: sender.name.split(' ').last
        fill_in 'MemberName', with: sender.email.split('@').first
        sender.email = "#{sender.email.split('@').first}@outlook.com"
        fill_in 'Password', with: sender.password
        fill_in 'RetypePassword', with: sender.password
        select 'Mexico', from: 'Country'

        select Date::MONTHNAMES[rand(11)+1], from: 'BirthMonth'
        select (rand(29)+1).to_s, from: 'BirthDay'
        select (rand(20)+1970).to_s, from: 'BirthYear'
        select 'Not specified', from: 'Gender'
        #click_link 'iliveswitch'
        
        
        select 'Mexico ‏(‎+52)', from: 'PhoneCountry'
        fill_in 'PhoneNumber', with: Sender.mobile_number
        
        #click_link 'iqsaswitch'
        #select 'Name of first pet', from: 'iSQ'
        #fill_in 'iSA', with: 'Scooby Doo'
        
        #sleep 2
        #fill_in 'iZipCode', with: (rand(100)+1240000).to_s
        
        debugger
        #sender.save! Set captcha and save manually
        
        logger.info "== Sender #{sender.email} created!" if sender.persisted?
      rescue Exception => e
        logger.error "== Error: #{e.message}"
      end
    end

  end
end