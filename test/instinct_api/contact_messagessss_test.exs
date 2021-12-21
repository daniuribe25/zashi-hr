defmodule ZashiHR.ContactMessagessssTest do
  use ZashiHR.DataCase

  alias ZashiHR.ContactMessagessss

  describe "contact_messages" do
    alias ZashiHR.ContactMessagessss.ContactMessagesss

    @valid_attrs %{email: "some email", fullname: "some fullname", message: "some message", phone: "some phone"}
    @update_attrs %{email: "some updated email", fullname: "some updated fullname", message: "some updated message", phone: "some updated phone"}
    @invalid_attrs %{email: nil, fullname: nil, message: nil, phone: nil}

    def contact_messagesss_fixture(attrs \\ %{}) do
      {:ok, contact_messagesss} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ContactMessagessss.create_contact_messagesss()

      contact_messagesss
    end

    test "list_contact_messages/0 returns all contact_messages" do
      contact_messagesss = contact_messagesss_fixture()
      assert ContactMessagessss.list_contact_messages() == [contact_messagesss]
    end

    test "get_contact_messagesss!/1 returns the contact_messagesss with given id" do
      contact_messagesss = contact_messagesss_fixture()
      assert ContactMessagessss.get_contact_messagesss!(contact_messagesss.id) == contact_messagesss
    end

    test "create_contact_messagesss/1 with valid data creates a contact_messagesss" do
      assert {:ok, %ContactMessagesss{} = contact_messagesss} = ContactMessagessss.create_contact_messagesss(@valid_attrs)
      assert contact_messagesss.email == "some email"
      assert contact_messagesss.fullname == "some fullname"
      assert contact_messagesss.message == "some message"
      assert contact_messagesss.phone == "some phone"
    end

    test "create_contact_messagesss/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ContactMessagessss.create_contact_messagesss(@invalid_attrs)
    end

    test "update_contact_messagesss/2 with valid data updates the contact_messagesss" do
      contact_messagesss = contact_messagesss_fixture()
      assert {:ok, %ContactMessagesss{} = contact_messagesss} = ContactMessagessss.update_contact_messagesss(contact_messagesss, @update_attrs)
      assert contact_messagesss.email == "some updated email"
      assert contact_messagesss.fullname == "some updated fullname"
      assert contact_messagesss.message == "some updated message"
      assert contact_messagesss.phone == "some updated phone"
    end

    test "update_contact_messagesss/2 with invalid data returns error changeset" do
      contact_messagesss = contact_messagesss_fixture()
      assert {:error, %Ecto.Changeset{}} = ContactMessagessss.update_contact_messagesss(contact_messagesss, @invalid_attrs)
      assert contact_messagesss == ContactMessagessss.get_contact_messagesss!(contact_messagesss.id)
    end

    test "delete_contact_messagesss/1 deletes the contact_messagesss" do
      contact_messagesss = contact_messagesss_fixture()
      assert {:ok, %ContactMessagesss{}} = ContactMessagessss.delete_contact_messagesss(contact_messagesss)
      assert_raise Ecto.NoResultsError, fn -> ContactMessagessss.get_contact_messagesss!(contact_messagesss.id) end
    end

    test "change_contact_messagesss/1 returns a contact_messagesss changeset" do
      contact_messagesss = contact_messagesss_fixture()
      assert %Ecto.Changeset{} = ContactMessagessss.change_contact_messagesss(contact_messagesss)
    end
  end
end
