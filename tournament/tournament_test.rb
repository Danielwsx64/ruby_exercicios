require 'minitest/autorun'
require_relative 'tournament'

class TournamentTest < Minitest::Test
  def test_allow_add_teams
    skip
    tournament = Tournament.new()

    tournament.add_team("São Paulo")
    tournament.add_team("Santos")

    assert_equal "São Paulo", tournament.teams.first.name
    assert_equal "Santos", tournament.teams.last.name
  end

  def test_find_tournament_team_by_name
    skip
    tournament = Tournament.new()

    tournament.add_team("São Paulo")
    tournament.add_team("Santos")

    sao_paulo = tournament.find("São Paulo")

    assert_equal Team, sao_paulo.class
    assert_equal "São Paulo", sao_paulo.name
  end

  def test_find_tournament_return_nil_for_unknown_teams
    skip
    tournament = Tournament.new()

    tournament.add_team("São Paulo")

    assert_equal nil, tournament.find("Quinze de Piracicaba")
  end

  def test_valid_matches_results_return_true
    skip
    tournament = Tournament.new()

    tournament.add_team("São Paulo")
    tournament.add_team("Santos")

    assert_equal true, tournament.add_match_result("São Paulo", "win", "Santos")
    assert_equal true, tournament.add_match_result("São Paulo", "draw", "Santos")
    assert_equal true, tournament.add_match_result("São Paulo", "loss", "Santos")
  end

  def test_matches_results_for_teams_unknown_return_false
    skip
    tournament = Tournament.new()

    tournament.add_team("São Paulo")

    assert_equal false, tournament.add_match_result("São Paulo", "win", "Quinze de Piracicaba")
  end

  def test_unknown_results_return_false
    skip
    tournament = Tournament.new()

    tournament.add_team("São Paulo")
    tournament.add_team("Santos")

    assert_equal false, tournament.add_match_result("São Paulo", "vitoria", "Santos")
    assert_equal false, tournament.add_match_result("São Paulo", "empate", "Santos")
    assert_equal false, tournament.add_match_result("São Paulo", "derrota", "Santos")
  end

  def test_add_team_info_when_add_matches_results
    skip
    tournament = Tournament.new()

    sao_paulo = tournament.add_team("São Paulo")
    santos = tournament.add_team("Santos")

    assert_equal 0, sao_paulo.matches_played
    assert_equal 0, sao_paulo.wins
    assert_equal 0, sao_paulo.draws
    assert_equal 0, sao_paulo.losses
    assert_equal 0, sao_paulo.points

    assert_equal 0, santos.matches_played
    assert_equal 0, santos.wins
    assert_equal 0, santos.draws
    assert_equal 0, santos.losses
    assert_equal 0, santos.points

    tournament.add_match_result("São Paulo", "win", "Santos")

    assert_equal 1, sao_paulo.matches_played
    assert_equal 1, sao_paulo.wins
    assert_equal 0, sao_paulo.draws
    assert_equal 0, sao_paulo.losses
    assert_equal 3, sao_paulo.points

    assert_equal 1, santos.matches_played
    assert_equal 0, santos.wins
    assert_equal 0, santos.draws
    assert_equal 1, santos.losses
    assert_equal 0, santos.points

    tournament.add_match_result("São Paulo", "draw", "Santos")

    assert_equal 2, sao_paulo.matches_played
    assert_equal 1, sao_paulo.wins
    assert_equal 1, sao_paulo.draws
    assert_equal 0, sao_paulo.losses
    assert_equal 4, sao_paulo.points

    assert_equal 2, santos.matches_played
    assert_equal 0, santos.wins
    assert_equal 1, santos.draws
    assert_equal 1, santos.losses
    assert_equal 1, santos.points
  end

  def test_build_tournament_results
    skip
    tournament = Tournament.new()

    tournament.add_team("São Paulo")
    tournament.add_team("Santos")
    tournament.add_team("Palmeiras")
    tournament.add_team("Corintians")

    tournament.add_match_result("São Paulo", "win", "Santos")
    tournament.add_match_result("Palmeiras", "draw", "Corintians")

    tournament.add_match_result("Palmeiras", "win", "São Paulo")
    tournament.add_match_result("Santos", "win", "Corintians")

    tournament.add_match_result("Corintians", "loss", "São Paulo")

    results = <<~RESULTS
                    J   V   E   D   P
      São Paulo   | 3 | 2 | 0 | 1 | 7 |
      Palmeiras   | 2 | 1 | 1 | 0 | 4 |
      Santos      | 2 | 1 | 0 | 1 | 3 |
      Corintians  | 3 | 0 | 1 | 2 | 1 |
    RESULTS

    assert_equal results, tournament.results()
  end
end
