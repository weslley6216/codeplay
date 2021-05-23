require 'rails_helper'

describe 'Admin view lessons from a course and return to the previous page' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)
    lesson = Lesson.create!(name: 'Primeira aula', content: 'Tipos primitivos', course: course)

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Ver Aulas'

    expect(page).to have_content("#{lesson.name}")
    expect(page).to have_content("#{lesson.content}")
    expect(page).to have_link('Voltar', href: course_path(course))
  end

  it 'and no lessons is available' do

    instructor = Instructor.create!(name: 'Gustavo Guanabara',
                                    email: 'guanabara@codeplay.com')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Ver Aulas'
    expect(page).to have_content('Nenhuma aula disponível para este curso')
  end
end
