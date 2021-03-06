defmodule Spotify.CredentialsTest do
  use ExUnit.Case, async: true

  @atoken "access_token"
  @rtoken "refresh_token"
  @creds %Spotify.Credentials{access_token: @atoken, refresh_token: @rtoken}

  test "new/2 returns a Spotify.Credentials struct when given tokens" do
    assert @creds == Spotify.Credentials.new(@atoken, @rtoken)
  end

  describe "new/1 returns a Spotify.Credentials struct" do
    test "when given a Plug.Conn" do
      conn = Plug.Test.conn(:post, "/authenticate")
              |> Plug.Conn.fetch_cookies
              |> Plug.Conn.put_resp_cookie("spotify_access_token",  @atoken)
              |> Plug.Conn.put_resp_cookie("spotify_refresh_token", @rtoken)
      assert @creds == Spotify.Credentials.new(conn)
    end

    test "when given a Spotify.Credentials struct" do
      assert @creds == Spotify.Credentials.new(@creds)
    end
  end

  test "get_tokens_from_response/1 returns a Spotify.Credentials struct" do
    response = %{"access_token" => @atoken, "refresh_token" => @rtoken}
    assert @creds == Spotify.Credentials.get_tokens_from_response(response)
  end
end
