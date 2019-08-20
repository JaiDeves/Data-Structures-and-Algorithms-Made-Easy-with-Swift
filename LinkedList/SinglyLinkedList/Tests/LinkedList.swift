//Data structures and algorithms made easy by Narasimha Karumanchi - 5th Edition

///Singly Linked list implementation

import Foundation

public final class LinkedList<T> {
    
    /// Linked List's Node Class Declaration
    public class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        
        public init(value: T) {
            self.value = value
        }
    }
    
    /// Typealiasing the node class to increase readability of code
    public typealias Node = LinkedListNode<T>
    
    
    /// The head of the Linked List
    private(set) var head: Node?
    
    /// Computed property to iterate through the linked list and return the last node in the list (if any)
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    /// Computed property to check if the linked list is empty
    public var isEmpty: Bool {
        return head == nil
    }
    
    /// Computed property to iterate through the linked list and return the total number of nodes
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    /// Subscript function to return the node at a specific index
    ///
    /// - Parameter index: Integer value of the requested value's index
    public subscript(index: Int) -> T {
        let node = self.node(at: index)
        return node.value
    }
    
    /// Function to return the node at a specific index. Crashes if index is out of bounds (0...self.count)
    ///
    /// - Parameter index: Integer value of the node's index to be returned
    /// - Returns: LinkedListNode
    public func node(at index: Int) -> Node {
        assert(head != nil, "List is empty")
        assert(index >= 0, "index must be greater or equal to 0")
        
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            
            assert(node != nil, "index is out of bounds.")
            return node!
        }
    }
    
    /// Default initializer
    public init() {}
}

// Insertion
extension LinkedList{
    
    /// Insert a value at a specific index. Crashes if index is out of bounds (0...self.count)
    ///
    /// - Parameters:
    ///   - value: The data value to be inserted
    ///   - index: Integer value of the index to be insterted at
    public func insert(_ value: T, at index: Int) {
        let newNode = Node(value: value)
        insert(newNode, at: index)
    }
    
    /// Insert a copy of a node at a specific index. Crashes if index is out of bounds (0...self.count)
    ///
    /// - Parameters:
    ///   - node: The node containing the value to be inserted
    ///   - index: Integer value of the index to be inserted at
    public func insert(_ newNode: Node, at index: Int) {
        
        if index == 0 {
            //Inserting at the beginning
            newNode.next = head
            head = newNode
        } else {
            // Traverse the list to insert at position
            let prev = node(at: index - 1)
            let next = prev.next
            newNode.next = next
            prev.next = newNode
        }
    }
    
    
    /// Append a value to the end of the list
    ///
    /// - Parameter value: The data value to be appended
    public func append(_ value: T) {
        let newNode = Node(value: value)
        append(newNode)
    }
    
    /// Append a copy of a LinkedListNode to the end of the list.
    ///
    /// - Parameter node: The node containing the value to be appended
    public func append(_ node: Node) {
        let newNode = node
        if let lastNode = last {
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    /// Append a copy of a LinkedList to the end of the list.
    ///
    /// - Parameter list: The list to be copied and appended.
    public func append(_ list: LinkedList) {
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            append(node.value)
            nodeToCopy = node.next
        }
    }
    
}
