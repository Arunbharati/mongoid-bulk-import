# frozen_string_literal: true

require "spec_helper"

describe Mongoid::Persistable::Creatable do
  describe ".bulk_insert" do
    context "with Validation" do
      context "when provided an array of attributes" do
        context "with all valid data" do
          let(:users) do
            User.bulk_insert([{ name: "Jack" }, { name: "Matt" }])
          end

          it "creates the documents" do
            expect(users.num_inserts).to eq(2)
            expect(users.ids.length).to eq(2)
            expect(users.failed_instances).to match_array([])
          end
        end

        context "with some invalid data" do
          let(:users) do
            User.bulk_insert([{ name: "Jack" }, { name: "Josh" }])
          end

          it "creates the documents" do
            expect(users.num_inserts).to eq(1)
            expect(users.ids.length).to eq(1)
            expect(users.failed_instances.length).to eq(1)
          end
        end
      end

      context "when providing attributes" do
        context "with valid data" do
          let(:user) do
            User.bulk_insert(name: "Jhon")
          end

          it "it saves the document" do
            expect(user.num_inserts).to eq(1)
            expect(user.ids.length).to eq(1)
            expect(user.failed_instances).to match_array([])
          end
        end

        context "with invalid data" do
          let(:user) do
            User.bulk_insert(name: "Jhon")
          end

          it "it should return error for document" do
            expect(user.num_inserts).to eq(0)
            expect(user.ids.length).to eq(0)
            expect(user.failed_instances.length).to eq(1)
          end
        end
      end
    end

    context "without Validation" do
      context "when provided an array of attributes" do
        context "with all valid data" do
          let(:users) do
            User.bulk_insert([{ name: "Ryan" }, { name: "Peter" }], { validate: false })
          end

          it "creates the documents" do
            expect(users.num_inserts).to eq(2)
            expect(users.ids.length).to eq(2)
            expect(users.failed_instances).to match_array([])
          end
        end

        context "with some invalid data" do
          let(:users) do
            User.bulk_insert([{ name: "Ryan" }, { name: "Rob" }], { validate: false })
          end

          it "creates the documents" do
            expect(users.num_inserts).to eq(2)
            expect(users.ids.length).to eq(2)
            expect(users.failed_instances.length).to eq(0)
          end
        end
      end

      context "when providing attributes" do
        context "with valid data" do
          let(:user) do
            User.bulk_insert({ name: "Jacky" }, { validate: false })
          end

          it "it saves the document" do
            expect(user.num_inserts).to eq(1)
            expect(user.ids.length).to eq(1)
            expect(user.failed_instances).to match_array([])
          end
        end

        context "with invalid data" do
          let(:user) do
            User.bulk_insert({ name: "Jacky" }, { validate: false })
          end

          it "it should return error for document" do
            expect(user.num_inserts).to eq(1)
            expect(user.ids.length).to eq(1)
            expect(user.failed_instances.length).to eq(0)
          end
        end
      end
    end
  end
end
