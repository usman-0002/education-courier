class UserMailer < ApplicationMailer
  def notify_user_about_comment(comment)
    @comment = comment
    @blog_url = "#{ENV['RAILS_APP_URL']}blogs/#{comment.blog.id}"

    mail(to: comment.blog.user.email, cc: admin_emails, subject: 'Education Courier: New comment on your blog')
  end
end
