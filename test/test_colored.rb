# Source code copied from Chris Wanstrath (https://github.com/defunkt/colored)
#
# Copyright (c) 2010 Chris Wanstrath
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# Software), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


require 'test/unit'
require 'yaclic'


class TestColor < Test::Unit::TestCase

	def setup
		$colored = true
	end

	def teardown
		$colored = false
	end

  def test_one_color
    assert_equal "\e[31mred\e[0m", "red".red
  end

  def test_two_colors
    assert_equal "\e[34m\e[31mblue\e[0m\e[0m", "blue".red.blue
  end

  def test_background_color
    assert_equal "\e[43mon yellow\e[0m", "on yellow".on_yellow
  end

  def test_hot_color_on_color_action
    assert_equal "\e[31m\e[44mred on blue\e[0m", "red on blue".red_on_blue 
  end

  def test_modifier
    assert_equal "\e[1mway bold\e[0m", "way bold".bold
  end

  def test_modifiers_stack
    assert_equal "\e[4m\e[1munderlined bold\e[0m\e[0m", "underlined bold".bold.underline
  end

  def test_modifiers_stack_with_colors
    assert_equal "\e[36m\e[4m\e[1mcyan underlined bold\e[0m\e[0m\e[0m", "cyan underlined bold".bold.underline.cyan
  end

  def test_eol
    assert_equal "\e[2Knothing to see here really.", "nothing to see here really.".to_eol
  end

  def test_eol_with_with_two_colors
    assert_equal "\e[34m\e[31m\e[2Kblue\e[0m\e[0m", "blue".red.blue.to_eol
  end

  def test_eol_with_modifiers_stack_with_colors
    assert_equal "\e[36m\e[4m\e[1m\e[2Kcyan underlined bold\e[0m\e[0m\e[0m", "cyan underlined bold".bold.underline.cyan.to_eol
  end
end
