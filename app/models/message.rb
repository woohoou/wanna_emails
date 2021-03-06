class Message < ActiveRecord::Base
  belongs_to :project

  def sanitize(sender, recollection_page=nil, options={})
    self.switch_text(':name', sender.name)

    if recollection_page.present?
      self.switch_text(':url', recollection_page.page.uri)

      if recollection_page.recollection.name_label.present?
        self.switch_text ':recollection_name', recollection_page.recollection.name_label
      elsif recollection_page.recollection.unique_pages == true
        self.switch_text ':recollection_name', recollection_page.recollection.name
      else
        self.switch_text ':recollection_name', recollection_page.page.host
      end
    end

    if options[:html] == true
      self.switch_text "\r\n",'<br />'
      self.switch_text "Asurela.com",'www.Asurela.com'
    end

    if options[:js] == true
      self.switch_text "\r\n","\n"
    end

    self
  end

  def switch_text old_text, new_text
    self.subject = self.subject.gsub old_text, new_text
    self.text = self.text.gsub old_text, new_text
    self
  end
end