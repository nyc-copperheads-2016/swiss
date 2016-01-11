class Folder < ActiveRecord::Base
  has_ancestry :orphan_strategy => :adopt
  has_many :user_bookmark_categories
  belongs_to :user
end
# parent           Returns the parent of the record, nil for a root node
# parent_id        Returns the id of the parent of the record, nil for a root node
# root             Returns the root of the tree the record is in, self for a root node
# root_id          Returns the id of the root of the tree the record is in
# root?, is_root?  Returns true if the record is a root node, false otherwise
# ancestor_ids     Returns a list of ancestor ids, starting with the root id and ending with the parent id
# ancestors        Scopes the model on ancestors of the record
# path_ids         Returns a list the path ids, starting with the root id and ending with the node's own id
# path             Scopes model on path records of the record
# children         Scopes the model on children of the record
# child_ids        Returns a list of child ids
# has_children?    Returns true if the record has any children, false otherwise
# is_childless?    Returns true is the record has no children, false otherwise
# siblings         Scopes the model on siblings of the record, the record itself is included*
# sibling_ids      Returns a list of sibling ids
# has_siblings?    Returns true if the record's parent has more than one child
# is_only_child?   Returns true if the record is the only child of its parent
# descendants      Scopes the model on direct and indirect children of the record
# descendant_ids   Returns a list of a descendant ids
# subtree          Scopes the model on descendants and itself
# subtree_ids      Returns a list of all ids in the record's subtree
# depth            Return the depth of the node, root nodes are at depth 0