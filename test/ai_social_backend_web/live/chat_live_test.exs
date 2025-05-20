defmodule AiSocialBackendWeb.ChatLiveTest do
  import Phoenix.LiveViewTest
  use AiSocialBackendWeb.ConnCase

  test "disconnected and connected mount", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/chat")

    assert html =~ "this is working"
  end
end
