module PostsHelper
	def markdown_editor(form, property)
    helper = ActionView::Base.new
    code = form.text_area(property, class: 'box', size: "40x20")
    code.gsub!(/">/, '" v-model="input" >') 
    code += '<div id="preview" class="box" v-html="input | marked"></div>'
    code.html_safe
  end

end
