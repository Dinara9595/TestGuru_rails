module FlashHelper
  def flash_message(flash)
    if flash
      content_tag :p, flash, class: 'flash alert'
    end
  end
end
