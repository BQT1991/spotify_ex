defmodule Spotify.Cookies do
  @moduledoc """
    Convinience setters and getters for auth cookies
  """

  @doc """
    Returns a map of token cookies from a parsed response body
  """
  def get_cookies_from_response(map)
  def get_cookies_from_response(response) do
    %{ refresh_token: response["refresh_token"], access_token: response["access_token"]}
  end

  @doc """
  Sets the refresh token and access token and returns the conn.

    ##Example:
      Spotify.Cookies.set_cookies(conn, %{refresh_token: rt, access_token: at})
  """

  def set_cookies(conn, map)
  def set_cookies(conn, %{refresh_token: refresh_token, access_token: access_token}) do
    conn
    |> Plug.Conn.put_status(200)
    |> set_refresh_cookie(refresh_token)
    |> set_access_cookie(access_token)
  end

  @doc """
  Sets the refresh token
  """
  def set_refresh_cookie(conn, string)

  def set_refresh_cookie(conn, nil), do: conn
  def set_refresh_cookie(conn, refresh_token) do
    Plug.Conn.put_resp_cookie(conn, "spotify_refresh_token", refresh_token)
  end

  @doc """
  Sets the access token
  """

  def set_access_cookie(conn, string)

  def set_access_cookie(conn, nil), do: conn
  def set_access_cookie(conn, access_token) do
    Plug.Conn.put_resp_cookie(conn, "spotify_access_token", access_token)
  end

  @doc """
  Gets the access token
  """
  def get_access_cookie(conn) do
    conn.cookies["spotify_access_token"]
  end

  @doc """
  Gets the access token
  """
  def get_refresh_cookie(conn) do
    conn.cookies["spotify_refresh_token"]
  end
end
