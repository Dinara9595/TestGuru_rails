class BadgeAdditionService
  LEVEL_DIFFICULT = %w[light_level medium_level high_level]

  def initialize(current_test, current_user)
    @current_test = current_test
    @current_user = current_user
    @user_badges = []
  end

  def call
    current_test_parameters = [@current_test.test.category.name, @current_test.test.title, level_difficulty_string(@current_test.test.level)]
    total_parameters = check_by_parameters(current_test_parameters)
    total_parameters.each do |parameter|
      add_badges_by(parameter, @current_user)
    end if total_parameters
    @user_badges
  end

  def check_by_parameters(current_test_parameters)
    badges = Badge.all
    rule_parameters = []
    current_test_parameters.map do |parameter|
      badges.each do |badge|
        if badge.rule_parameter == parameter or "not"
          rule_parameters << parameter unless rule_parameters.include?(parameter)
        end
      end
    end if badges
    rule_parameters
  end

  def add_badges_by(parameter, user)
    add_badge(parameter, user) if check_param_category(parameter, user)
    add_badge(parameter, user) if check_param_level(parameter, user)
    add_badge("not", user) if check_param_first_try(parameter, user)
  end

  def check_param_category(parameter, user)
    check_by_category(parameter, user) if Category.only_name.include?(parameter) && [parameter].any?
  end

  def check_param_level(parameter, user)
    check_by_test_level(parameter, user) if Badge.only_level_difficult.include?(parameter) && [parameter].any?
  end

  def check_param_first_try(parameter, user)
    check_by_test_first_try(parameter, user) if Test.titles_all_tests.include?(parameter) && [parameter].any?
  end

  def check_by_category(category, user)
    number_of_tests_by_category = Test.only_title_tests(category)
    array_tests = []
    user.test_passages.each do |test_passage|
      array_tests << test_passage.test.title if test_passage.successful? && test_passage.test.category.name == category
    end
    array_tests.size == number_of_tests_by_category.size
  end

  def check_by_test_first_try(test_title, user)
    array_tests = []
    user.test_passages.each do |test_passage|
      array_tests << test_passage if test_passage.test.title == test_title
    end
    array_tests.size == 1 && array_tests[0].successful?
  end

  def check_by_test_level(level, user)
    number_of_tests_by_level = Test.send(level)
    array_tests = []
    number_of_tests_by_level.each do |test|
      user.test_passages.each do |test_passage|
        array_tests << test if test == test_passage.test && test_passage.successful?
      end
    end
    array_tests.size == number_of_tests_by_level.size
  end

  def level_difficulty_string(level)
    case level
    when 0..1
      LEVEL_DIFFICULT[0]
    when 2..4
      LEVEL_DIFFICULT[1]
    when 5..Float::INFINITY
      LEVEL_DIFFICULT[2]
    end
  end

  def add_badge(parameter, user)
    param = parameter.gsub(/\s+/, "_").downcase
    badge = Badge.find_by(rule_parameter: param)
    if badge
      user.badges.push(badge)
      @user_badges << badge
    end
  end
end
