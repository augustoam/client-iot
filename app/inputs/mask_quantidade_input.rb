class MaskQuantidadeInput < SimpleForm::Inputs::StringInput
  def input_html_classes
    super.push('mask').push('quantidade')
  end
end
