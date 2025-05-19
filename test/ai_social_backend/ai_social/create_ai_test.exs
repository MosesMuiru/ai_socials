defmodule AiSocialBackend.AiSocial.CreateAiTest do
  use ExUnit.Case

  test "if create ai agents returns true " do
    assert AiSocialBackend.CreateAi.create_ai(5) == true
  end

  test "if you use string it will work" do
    assert AiSocialBackend.CreateAi.create_ai("five") == false
  end
end
