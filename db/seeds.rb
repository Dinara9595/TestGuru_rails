users = User.create!([{login: 'Dinara', password: '1234'}, {login: 'Di', password: 'qwerty'}])
categories = Category.create!([{name: 'Солнечная система'}, {name: 'Животный мир'}, {name: 'Созвездия'}])

tests = Test.create!([{title: 'Планеты', level: 0, category_id: categories[0].id, author_id: users[0].id},
                     {title: 'Планета Земля', level: 0, category_id: categories[0].id, author_id: users[0].id},
                     {title: 'Птицы', level: 1, category_id: categories[1].id, author_id: users[0].id},
                     {title: 'Большая Медведица', level: 2, category_id: categories[2].id, author_id: users[0].id},
                     {title: 'Рыбы', level: 1, category_id: categories[1].id, author_id: users[0].id}])




questions = Question.create!([{body: 'Сколько планет в Солнечной системе?', test_id: tests[0].id},
                              {body: 'Сколько часов в сутках на планете Земля?', test_id: tests[1].id},
                              {body: 'Какое самое холодное время года планеты Земля?', test_id: tests[1].id},
                              {body: 'Выбери вариант ответа, что соотвествует категории Птица', test_id: tests[2].id},
                              {body: 'Сколько звезд в созвездии Большая Медведица?', test_id: tests[3].id},
                              {body: 'Выбери вариант ответа, что соотвествует категории Рыбы', test_id: tests[4].id}])


Answer.create!([{body: '8', correct: true, question_id: questions[0].id},
                          {body: '5', correct: false, question_id: questions[0].id},
                          {body: '20', correct: false, question_id: questions[1].id},
                          {body: '24', correct: true, question_id: questions[1].id},
                          {body: 'Зима', correct: true, question_id: questions[2].id},
                          {body: 'Лето', correct: false, question_id: questions[2].id},
                          {body: 'Мышь', correct: false, question_id: questions[3].id},
                          {body: 'Жаворонок', correct: true, question_id: questions[3].id},
                          {body: 'Пчела', correct: false, question_id: questions[3].id},
                          {body: '10', correct: false, question_id: questions[4].id},
                          {body: '7', correct: true, question_id: questions[4].id},
                          {body: 'Карп', correct: true, question_id: questions[5].id},
                          {body: 'Муравей', correct: true, question_id: questions[5].id},
                          {body: 'Гнездо', correct: true, question_id: questions[5].id}])

passed_tests = PassedTest.create!([{test_id: tests[0].id, user_id: users[0].id},
                                   {test_id: tests[1].id, user_id: users[1].id},
                                   {test_id: tests[2].id, user_id: users[1].id},
                                   {test_id: tests[4].id, user_id: users[1].id}])