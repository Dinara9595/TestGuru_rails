users = User.create!([{ email: 'Di@example.com', password: '123456' }, { email: 'Dinara@example.com', password: 'qwerty' }])
categories = Category.create!([{ name: 'Солнечная система' }, { name: 'Животный мир' }, { name: 'Созвездия' }])
tests = Test.create!([{ title: 'Планеты', level: 0, category: categories[0], author: users[0] },
                      { title: 'Планета Земля', level: 5, category: categories[0], author: users[0] },
                      { title: 'Птицы', level: 3, category: categories[1], author: users[0] },
                      { title: 'Большая Медведица', level: 2, category: categories[2], author: users[0] },
                      { title: 'Рыбы', level: 1, category: categories[1], author: users[0] }])

questions = Question.create!([{ body: 'Сколько планет в Солнечной системе?', test: tests[0] },
                              { body: 'Сколько часов в сутках на планете Земля?', test: tests[1] },
                              { body: 'Какое самое холодное время года планеты Земля?', test: tests[1] },
                              { body: 'Выбери вариант ответа, что соотвествует категории Птица', test: tests[2] },
                              { body: 'Сколько звезд в созвездии Большая Медведица?', test: tests[3] },
                              { body: 'Выбери вариант ответа, что соотвествует категории Рыбы', test: tests[4] }])

Answer.create!([{ body: '8', correct: true, question: questions[0] },
                { body: '5', correct: false, question: questions[0] },
                { body: '20', correct: false, question: questions[0] },
                { body: '24', correct: true, question: questions[1] },
                { body: 'Зима', correct: true, question: questions[2] },
                { body: 'Лето', correct: false, question: questions[2] },
                { body: 'Мышь', correct: false, question: questions[3] },
                { body: 'Жаворонок', correct: true, question: questions[3] },
                { body: 'Пчела', correct: false, question: questions[3] },
                { body: '10', correct: false, question: questions[4] },
                { body: '7', correct: true, question: questions[4] },
                { body: 'Карп', correct: true, question: questions[5] },
                { body: 'Муравей', correct: false, question: questions[5] },
                { body: 'Гнездо', correct: false, question: questions[5] }])

admins = Admin.create!([{ email: "admin@example.com", password: "qwerty", first_name: "Admin", last_name: "Adminov" }])

badge_rules = BadgeRule.create!([{ name: 'Успешное прохождение тестов одной категории', author_rule: admins[0] },
                                 { name: 'Успешное прохождение теста с первой попытки', author_rule: admins[0] },
                                 { name: 'Успешное прохождение тестов одного уровня', author_rule: admins[0] }])

Badge.create!([{ name: "Желтая звезда", file_name: "badge_category.jpg", author_badge: admins[0], badge_rule: badge_rules[0] },
               { name: "Зеленая звезда", file_name: "badge_level.jpg", author_badge: admins[0], badge_rule: badge_rules[1] },
               { name: "Фиолетовая звезда", file_name: "badge_first_try.jpg", author_badge: admins[0], badge_rule: badge_rules[2] }])


