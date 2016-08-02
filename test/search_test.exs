defmodule SearchTest do
  use ExUnit.Case
  alias Spotify.{Search, Artist, Album, Playlist, Track}

  describe "build_response/1" do
    test "responds with artists" do
      response = %{ "artists" => [ %{"name" => "foo"} ] }

      expected = %Paging{items: [%Artist{name: "foo"}]}
      actual = Search.build_response(response)

      assert actual == expected
    end

    test "responds with tracks" do
      response = %{ "tracks" => [ %{"name" => "foo"} ] }

      expected = %Paging{items: [%Track{name: "foo"}]}
      actual = Search.build_response(response)

      assert actual == expected
    end

    test "responds with playlists" do
      response = %{ "playlists" => [ %{"name" => "foo"} ] }

      expected = %Paging{items: [%Playlist{name: "foo"}]}
      actual = Search.build_response(response)

      assert actual == expected
    end

    test "responds with albums" do
      response = %{ "albums" => [ %{"name" => "foo" }]}

      expected = %Paging{items: [%Album{name: "foo"}] }

      actual = Search.build_response(response)

      assert actual == expected
    end
  end
end
