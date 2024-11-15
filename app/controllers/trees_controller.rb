# frozen_string_literal: true

class TreesController < ApplicationController
  before_action :set_family_tree

  def set_family_tree
    family = Family.find(params[:id])
    ancestor = family.ancestor
    @family_tree = [ build_family_tree(ancestor) ] if ancestor.presence
  end

  def show
    @id = params[:id]
    render
  end

  def gender_to_class(gender)
    gender === "male" ? "man" : "woman"
  end

  def build_family_tree(member)
    {
      name: member.name,
      class: gender_to_class(member.gender),
      textClass: "emphasis",
      marriages: marriages(member)
    }
  end

  def marriages(member)
    spouses = case member.gender
    when "male"
      member.spouses
    when "female"
      Member.spouses_of(member.id)
    end

    return [] unless spouses.presence

    spouse = {}
    children = []
    result = [
      spouse: spouse,
      children: children
    ]
    children = case member.gender
    when "male"
      spouses.first.children
    when "female"
      member.children
    end

    if spouses.presence
      result[0][:spouse] = {
        name: spouses.first.name,
        class: gender_to_class(spouses.first.gender)
      }
    end

    if children.presence
      result[0][:children] = children.map do |child|
        build_family_tree(child)
      end
    end
    result
  end
end
