module ResponseSelector
  DEFAULT_KEY_MAP = {
    login: :user_name,
    id: :id,
    name: :name,
    company: :company,
    email: :email,
    avatar_url: :avatar_url,
    url: :profile_url,
    created_at: :created_at
  }

  def select_expected_data(response, keys = [])
    expected_response_keys = DEFAULT_KEY_MAP.keys.union(keys)
    response.slice(*expected_response_keys)
  end
end
