defmodule ZashiHR.ContactMessagesTest do
  use ZashiHR.DataCase

  alias ZashiHR.ContactMessages

  describe "contact_messages" do
    alias ZashiHR.ContactMessages.ContactMessage

    @valid_attrs %{email: "some email", fullname: "some fullname", message: "some message", phone: "some phone"}
    @update_attrs %{email: "some updated email", fullname: "some updated fullname", message: "some updated message", phone: "some updated phone"}
    @invalid_attrs %{email: nil, fullname: nil, message: nil, phone: nil}

    def contact_message_fixture(attrs \\ %{}) do
      {:ok, contact_message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ContactMessages.create_contact_message()

      contact_message
    end

    test "list_contact_messages/0 returns all contact_messages" do
      contact_message = contact_message_fixture()
      assert ContactMessages.list_contact_messages() == [contact_message]
    end

    test "get_contact_message!/1 returns the contact_message with given id" do
      contact_message = contact_message_fixture()
      assert ContactMessages.get_contact_message!(contact_message.id) == contact_message
    end

    test "create_contact_message/1 with valid data creates a contact_message" do
      assert {:ok, %ContactMessage{} = contact_message} = ContactMessages.create_contact_message(@valid_attrs)
      assert contact_message.email == "some email"
      assert contact_message.fullname == "some fullname"
      assert contact_message.message == "some message"
      assert contact_message.phone == "some phone"
    end

    test "create_contact_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ContactMessages.create_contact_message(@invalid_attrs)
    end

    test "update_contact_message/2 with valid data updates the contact_message" do
      contact_message = contact_message_fixture()
      assert {:ok, %ContactMessage{} = contact_message} = ContactMessages.update_contact_message(contact_message, @update_attrs)
      assert contact_message.email == "some updated email"
      assert contact_message.fullname == "some updated fullname"
      assert contact_message.message == "some updated message"
      assert contact_message.phone == "some updated phone"
    end

    test "update_contact_message/2 with invalid data returns error changeset" do
      contact_message = contact_message_fixture()
      assert {:error, %Ecto.Changeset{}} = ContactMessages.update_contact_message(contact_message, @invalid_attrs)
      assert contact_message == ContactMessages.get_contact_message!(contact_message.id)
    end

    test "delete_contact_message/1 deletes the contact_message" do
      contact_message = contact_message_fixture()
      assert {:ok, %ContactMessage{}} = ContactMessages.delete_contact_message(contact_message)
      assert_raise Ecto.NoResultsError, fn -> ContactMessages.get_contact_message!(contact_message.id) end
    end

    test "change_contact_message/1 returns a contact_message changeset" do
      contact_message = contact_message_fixture()
      assert %Ecto.Changeset{} = ContactMessages.change_contact_message(contact_message)
    end
  end
end
