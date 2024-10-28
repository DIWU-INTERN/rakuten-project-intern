class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    if resource
      sign_in(resource_name, resource)
      render json: { message: 'ログインに成功しました。' }, status: :ok
    else
      render json: { error: 'メールアドレスまたはパスワードが正しくありません。' }, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end
end
