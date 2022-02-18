module TestsHelper

  TEST_LEVELS = {0 => :light, 1 => :light, 2 => :medium, 3 => :medium, 4 => :medium, 5 => :high}.freeze

  def test_level(test)
    TEST_LEVELS[test.level] || :high
  end
end
