# frozen_string_literal: true

require 'spec_helper'

describe 'manifest_whitespace_class_name_single_space_before' do
  let(:single_space_msg) {
    'there should be a single space between the class or defined resource statement and the name'
  }

  context 'with two spaces' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class  example {
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(6)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the space' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class example {
              class  { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end

  context 'with inherits' do
    let(:code) do
      'class example inherits otherexample {'
    end

    it 'should detect no problems' do
      expect(problems).to be_empty
    end
  end
end

describe 'manifest_whitespace_class_name_single_space_after' do
  let(:single_space_msg) { 'there should be a single space between the class or resource name and the next item' }

  context 'with inherits' do
    let(:code) do
      <<~EOF
        class example inherits otherexample {
          assert_private()
        }
      EOF
    end

    it 'should detect no problems' do
      expect(problems).to be_empty
    end
  end

  context 'with parameters and no spaces' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class myclass(
          $param1,
        ) {
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(7)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the newline' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class myclass (
              $param1,
            ) {
              class  { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end

  context 'with scope and no spaces' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class mymodule::example{
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(7)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the newline' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class mymodule::example {
              class  { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end

  context 'with no spaces' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class example{
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(7)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the newline' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class example {
              class  { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end

  context 'with two spaces' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class example  {
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(7)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the space' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class example {
              class  { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end

  context 'with newline' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class example


          {
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    context 'with fix disabled' do
      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a error' do
        expect(problems).to contain_error(single_space_msg).on_line(6).in_column(7)
      end
    end

    context 'with fix enabled' do
      before do
        PuppetLint.configuration.fix = true
      end

      after do
        PuppetLint.configuration.fix = false
      end

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the manifest' do
        expect(problems).to contain_fixed(single_space_msg)
      end

      it 'should fix the newline' do
        expect(manifest).to eq(
          <<~EOF,
            # example
            #
            # Main class, includes all other classes.
            #

            class example {
              class  { 'example2':
                param1 => 'value1',
              }
            }
          EOF
        )
      end
    end
  end

  context 'with comment' do
    let(:code) do
      <<~EOF
        # example
        #
        # Main class, includes all other classes.
        #

        class example # the class
        {
          class  { 'example2':
            param1 => 'value1',
          }
        }
      EOF
    end

    it 'should detect no problem' do
      expect(problems).to be_empty
    end
  end
end
