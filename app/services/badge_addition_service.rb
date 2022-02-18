class BadgeAdditionService

  def initialize(current_test, current_user)
    @current_test_passage = current_test
    @current_user = current_user
  end

  def call
    Badge.select do |badge|
      send(badge.rule, badge.rule_parameter)
    end
  end

  private

  def by_category?(category)
    category = category.gsub(/_/, " ").capitalize
    number_of_tests_by_category = Test.only_title_tests(category)
    array_tests = []
    @current_user.test_passages.each do |test_passage|
      array_tests << test_passage.test.title if test_passage.successful? && test_passage.test.category.name == category
    end
    array_tests.size == number_of_tests_by_category.size
  end

  def first_try?(parameter)
    parameter = @current_test_passage.test.title if parameter == "not"
    array_tests = []
    @current_user.test_passages.each do |test_passage|
      array_tests << test_passage if test_passage.test.title == parameter
    end
    array_tests.size == 1 && array_tests[0].successful?
  end

  def by_level?(level)
    number_of_tests_by_level = Test.send(level)
    array_tests = []
    number_of_tests_by_level.each do |test|
      @current_user.test_passages.each do |test_passage|
        array_tests << test if test == test_passage.test && test_passage.successful?
      end
    end
    array_tests.size == number_of_tests_by_level.size
  end
end
