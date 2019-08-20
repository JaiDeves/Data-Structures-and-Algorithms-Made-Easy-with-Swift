//Data structures and algorithms made easy by Narasimha Karumanchi - 5th Edition

///Singly Linked list implementation

import Foundation




open class SingleCircularLinkedList<T:Equatable> {
    
    
    open class Node<T: Equatable> {
        var value: T
        var next: Node?
        
        
        public init(value: T) {
            self.value = value
        }
        
        static func == (lhs: Node, rhs: Node) -> Bool {
            return lhs.value == rhs.value
        }
        static func != (lhs: Node, rhs: Node) -> Bool {
            return lhs.value != rhs.value
        }
    }
    
    
    /// The head of the Linked List
    private(set) var head: Node<T>?
    
    
    /// Computed property to iterate through the linked list and return the last node in the list (if any)
    public var last: Node<T>? {
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
        guard let current = head else {
            return 0
        }
        var count = 1
        while let node = current.next{
            count += 1
            if node == head!{
                break
            }
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
    public func node(at index: Int) -> Node<T> {
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

//: Insertion
extension SingleCircularLinkedList{
    
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
    public func insert(_ newNode: Node<T>, at index: Int) {
        
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
    public func append(_ node: Node<T>) {
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
    public func append(_ list: SingleCircularLinkedList) {
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            append(node.value)
            nodeToCopy = node.next
        }
    }
    
}

//: Deletion
extension SingleCircularLinkedList{
    
    /// Function to remove all nodes/value from the list
    public func removeAll() {
        head = nil
    }
    
    
    /// Function to remove the last node/value in the list. Crashes if the list is empty
    ///
    /// - Returns: The data value contained in the deleted node.
    @discardableResult public func removeFirst() -> T {
        assert(!isEmpty)
        return remove(at: 0)
    }
    
    /// Function to remove the last node/value in the list. Crashes if the list is empty
    ///
    /// - Returns: The data value contained in the deleted node.
    @discardableResult public func removeLast() -> T {
        assert(!isEmpty)
        return remove(at: count - 1)
    }
    
    /// Function to remove a node/value at a specific index. Crashes if index is out of bounds (0...self.count)
    ///
    /// - Parameter index: Integer value of the index of the node to be removed
    /// - Returns: The data value contained in the deleted node
    @discardableResult public func remove(at index: Int) -> T {
        precondition(!isEmpty)
        precondition((index >= 0) && (index < self.count))
        
        var i = 0;
        var current = head
        var previous:Node<T>?
        defer {
            current = nil
        }
        if index == 0{
            head = current?.next
            return current!.value
        }
        while (i < index) {
            previous = current
            current = current?.next
            i += 1
        }
        
        previous?.next = current?.next
        
        return current!.value
    }
}


// MARK: - Extension to enable the standard conversion of a list to String
extension SingleCircularLinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while let nd = node {
            s += "\(nd.value)"
            node = nd.next
            if node! != head! {
                s += ", "
                continue
            }
            break
        }
        return s + "]"
    }
}





//: Testing
let list = SingleCircularLinkedList<String>()
print(list)
list.insert("Hello", at: 0)
list.append("World")
list.append("It's")
list.append("Jai")
//
//list.node(at: 0).value    // "Hello"
//list.node(at: 1).value    // "World"
//
//
//list[0]     // "Hello"
//list[1]     // "World"
//
//
//list.remove(at: 2)
//list.removeFirst()
//
//print(list)


/// Linked List's Node Class Declaration
