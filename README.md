<div align="center">
  <h3 align="center">rails-project-63</h3>
</div>

<!-- ABOUT THE PROJECT -->
[![hexlet-check](https://github.com/Kroched/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Kroched/rails-project-63/actions/workflows/hexlet-check.yml)
[![Ruby CI](https://github.com/Kroched/rails-project-63/actions/workflows/ruby_ci.yml/badge.svg)](https://github.com/Kroched/rails-project-63/actions/workflows/ruby_ci.yml)

## О проекте

Простой генератор формы наподобие SimpleForm


<!-- GETTING STARTED -->


<!-- USAGE EXAMPLES -->
## Использование
```ruby
require 'HexletCode'
User = Struct.new(:name, :job, keyword_init: true)
user = User.new job: 'hexlet'

HexletCode.form_for user do |f|
  f.input :name
  f.input :job
  f.submit
end

# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input name="name" type="text" value="">
#   <label for="job">Job</label>
#   <input name="job" type="text" value="hexlet">
#   <input type="submit" value="Save">
# </form>

```
