# base
#base_color = "#b3ff00"
#base_color = "#ffb300"
base_color = "#458cff"
base_light_color = "#66aa66"
base_light_background_color = "#feedb9"
base_background_color = "#feedb9"

set_graffiti_color("#{base_color}99")
set_graffiti_line_width(30)

set_progress_foreground(base_color)
set_progress_background(base_background_color)

#@default_item1_mark_color = base_light_color
#@default_item1_mark_type = "check"
#@default_item2_mark_color = base_light_color
#@default_item2_mark_type = "check"
#@default_item3_mark_color = base_light_color
#@default_item3_mark_type = "check"
#@default_enum_item1_mark_color = base_light_color
#@default_enum_item1_mark_type = "check"
#@default_enum_item2_mark_color = base_light_color
#@default_enum_item2_mark_type = "check"
#@default_description_item1_mark_color = base_light_color
@default_block_quote_item1_mark_color = base_light_color
@description_term_line_color = base_light_color

@default_emphasis_color = base_color

@preformatted_frame_color = base_light_color
@preformatted_fill_color = base_background_color

@block_quote_frame_color = base_light_color
@block_quote_fill_color = base_background_color

@table_frame_color = base_light_color
@table_fill_color = base_background_color
@table_body_frame_color = base_light_color
@table_body_fill_color = base_background_color
@table_head_frame_color = base_light_color
@table_head_fill_color = base_light_background_color

@xxxx_large_font_size = screen_size(10 * Pango::SCALE)
@xxx_large_font_size = screen_size(8 * Pango::SCALE)
@xx_large_font_size = screen_size(6 * Pango::SCALE)
@x_large_font_size = screen_size(5 * Pango::SCALE)
@large_font_size = screen_size(4.5 * Pango::SCALE)
@normal_font_size = screen_size(3.5 * Pango::SCALE)
@small_font_size = screen_size(2.5  * Pango::SCALE)
@x_small_font_size = screen_size(2 * Pango::SCALE)
@xx_small_font_size = screen_size(1.4 * Pango::SCALE)
@xxx_small_font_size = screen_size(1.0 * Pango::SCALE)
@script_font_size = @xxx_small_font_size
@large_script_font_size = @xx_small_font_size
@x_large_script_font_size = @x_small_font_size

#@default_headline_line_expand = true
@default_headline_line_color = "#fff9c5"
@default_headline_line_width = 1
@slide_header_info_line_params = {
  :pattern => {
    :base => [0, 0, canvas.width, 0],
    :type => :linear,
    :color_stops => [
                     [0.0, 1, 0.976, 0.772],
                     [0.3, 0.258, 0.592, 0.266],
                     [0.7, 0.258, 0.592, 0.266],
                     [1.0, 1, 0.976, 0.772],
                    ],
  }
}
@slide_header_info_base_y = canvas.height * 0.125
include_theme("slide-header-info")

add_image_path("rabbit-images")

#@block_quote_open_quote_image = "open-quote-blue.png"
#@block_quote_close_quote_image = "close-quote-blue.png"
@block_quote_title_font_size = @x_small_font_size * 0.8

@margin_bottom = canvas.height * 0.05
@font_family = find_font_family("Yutapon coding Regular")
@monospace_font_family = find_font_family("Yutapon coding Regular")

add_image_path("eucalyptusja-images")
@image_slide_number_image ||= "puta2.png"
@image_slide_number_show_text = false
@image_slide_number_start_image = "eucalyptusja-start-flag.png"
@image_slide_number_goal_image = "eucalyptusja-goal-flag.png"
@image_timer_image ||= "mogtan1.png"

@headline_logo_image = 'puta_su1.png'

include_theme("default")
include_theme("newline-in-title")

include_theme("headline-logo")



set_background("#fff9c5")

match(TitleSlide, "*") do |elements|
  elements.horizontal_centering = false
  elements.align = :right
  set_font_family(elements)
end

match(TitleSlide, Title) do |titles|
  titles.padding_bottom = @space * 2
end

match(Slide, HeadLine) do |heads|
#  name = "head-line"
#  heads.delete_post_draw_proc_by_name(name)
#  heads.horizontal_centering = true
#  set_font_family(heads)

  heads.prop_set("foreground", "#429744")
  heads.prop_set("size", screen_size(4) * Pango::SCALE)
  heads.horizontal_centering = true
end

match(Slide, Body) do |bodies|
  bodies.vertical_centering = true
  bodies.each do |body|
    set_font_family(body)
    next if body.elements.all? {|element| element.is_a?(Image)}
    next if body.elements.any? {|element| element.is_a?(BlockQuote)}
    next if body.elements.any? {|element| element.is_a?(PreformattedBlock)}
    next if body.elements.any? {|element| element.is_a?(Table)}
    body.margin_left = canvas.width * 0.05
    body.margin_right = canvas.width * 0.05
  end
end

#----------------------------------------
# item mark setup
#----------------------------------------
# item setup need update!!
slide_body = [Slide, Body]
item_list_item = [ItemList, ItemListItem]
match(*(slide_body + (item_list_item * 1))) do |items|
  name = "item1"
  items.delete_pre_draw_proc_by_name(name)
  items.delete_post_draw_proc_by_name(name)
  draw_image_mark(items, "item1.png", name)
end
match(*(slide_body + (item_list_item * 2))) do |items|
  name = "item2"
  items.delete_pre_draw_proc_by_name(name)
  items.delete_post_draw_proc_by_name(name)
  draw_image_mark(items, "item2.png", name)
end
match(*(slide_body + (item_list_item * 3))) do |items|
  name = "item3"
  items.delete_pre_draw_proc_by_name(name)
  items.delete_post_draw_proc_by_name(name)
  draw_image_mark(items, "item3.png", name)
end

proc_name = "title-background-image"
match(TitleSlide) do |contents|
  contents.prop_set("foreground", "#104010")
end

@slide_footer_info_left_text ||= canvas.title
@slide_footer_info_right_text ||= "Powered by Rabbit #{Rabbit::VERSION}"
@slide_footer_info_line_params ||= {
  :pattern => {
    :base => [0, 0, canvas.width, 0],
    :type => :linear,
    :color_stops => [
                     [0.0, 1, 0.976, 0.772],
                     [0.3, 0.258, 0.592, 0.266],
                     [0.7, 0.258, 0.592, 0.266],
                     [1.0, 1, 0.976, 0.772],
                    ],
  }
}
@slide_footer_info_text_color = "#104010"
include_theme("slide-footer-info")

# takahashi method
@lightning_talk_color = base_light_color
@lightning_talk_font_family = find_font_family("Cica")
@lightning_talk_background_color = base_background_color
@lightning_talk_proc_name = "lightning-simple"
@lightning_talk_as_large_as_possible = true

include_theme("lightning-talk-toolkit")

match(Slide) do |slides|
  slides.each do |slide|
    if slide.lightning_talk?
      slide.lightning_talk
    end
  end
end

@lightning_talk_nari_slide_params = {}

def slide_params(slide)
  res = {}
  if !slide["size"].nil? && !slide["size"].empty?
    res[:size] = screen_size(slide["size"].to_i * Pango::SCALE)
  end
  %w(color family backgroundcolor).each do |key|
    unless slide[key].nil? || slide[key].empty?
      slide_key = key == "backgroundcolor" ? "background_color" : key
      res[slide_key.to_sym] = slide[key]
    end
  end
  res[:as_large_as_possible] = false unless res.empty?
  res
end


# All slide property were used first slide property.
match(Slide) do |slides|
  slides.each_with_index do |slide, index|
    if index.zero?
      @lightning_talk_nari_slide_params = slide_params(slide)
    end
    if slide.lightning_talk?
      adhock_params = slide_params(slide)
      slide.lightning_talk(
        adhock_params.empty? ? @lightning_talk_nari_slide_params : adhock_params)
    end
  end
end

include_theme("per-slide-background-color")
include_theme("per-slide-background-image")

# headline-position
#
# Usage: 
#  :headline-position
#    bottom-right
match(Slide) do |slides|
  slides.each do |slide|
    headline_position = slide["headline-position"]
    next if headline_position.nil?

    slide.horizontal_centering = false
    head = slide.headline
    head.horizontal_centering = false
    head.vertical_centering = false

    case headline_position.split("-").first
    when "top"
      head.margin_bottom = canvas.height * 0.5
    when "bottom"
      head.align = :right
      head.margin_top = canvas.height * 0.5
    end

    case headline_position.split("-")[1]
    when "right"
      head.align = :right
      head.margin_right = canvas.width * 0.05
    when "left"
      head.align = :left
      head.margin_left = canvas.width * 0.05
    when "center"
      head.align = :center
    end
  end
end

# enable headline-align
match(Slide) do |slides|
  slides.each do |slide|
    headline_align = slide["headline-align"]
    next if headline_align.nil?

    slide.horizontal_centering = false
    slide.headline.horizontal_centering = false
  end
end

# background-image-credit
#
# Usage: 
#  :background-image
#    images/steal_rabbit.jpg
#  :background-image-credit
#    http://www.flickr.com/photos/ryanr/157458385/

set_foreground("#305030")

match(Slide) do |slides|
  slides.each do |slide|
    credit = slide["background-image-credit"]
    next if credit.nil?

    slide.add_pre_draw_proc(name) do |canvas, x, y, w, h, simulation|
      props = {
        "font_family" => slide[:family],
        "size" => screen_size(1.5 * Pango::SCALE),
        "color" => "#6a6",
      }
      right_layout = make_layout(span(props, credit))
      text_width, text_height = right_layout.pixel_size
      canvas.draw_layout(right_layout, (canvas.width - text_width - screen_x(1)), canvas.height - @margin_bottom)
      [x, y, w, h]
    end
  end
end
