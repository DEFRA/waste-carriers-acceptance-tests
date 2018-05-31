class WriteOffsPage < SitePrism::Page

  # Write off difference

  element(:comment, "#payment_comment")

  element(:submit_button, "#write_off")

  def submit(args = {})
    comment.set(args[:comment]) if args.key?(:comment)

    submit_button.click
  end

end
