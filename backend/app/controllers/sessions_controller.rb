class SessionsController < Devise::SessionsController
  # POST /users/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)

    if resource
      sign_in(resource_name, resource)
      render json: { user: resource, message: 'ログインに成功しました。' }, status: :ok
    else
      render json: { error: 'メールアドレスまたはパスワードが正しくありません。' }, status: :unprocessable_entity
    end
  rescue StandardError => e
    Rails.logger.error("ログインエラー: #{e.message}")
    render json: { error: '内部サーバーエラーが発生しました。' }, status: :internal_server_error
  end

  private

  # デフォルトの認証オプションを設定
  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
