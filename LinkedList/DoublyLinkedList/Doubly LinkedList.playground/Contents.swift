import UIKit


public struct LinkedList<Element> {
    private var headNode: LinkedListNode<Element>?
    private var tailNode: LinkedListNode<Element>?
    public private(set) var count: Int = 0
    
    public init() { }
}

//MARK: LinkedList Node Type
extension LinkedList {
    
    fileprivate typealias Node<T> = LinkedListNode<T>
    
    fileprivate class LinkedListNode<T> {
        public var value: T
        private var setAutomatically = true
        public var next: LinkedListNode<T>? {
            didSet {
                if setAutomatically {
                    next?.setAutomatically = false
                    next?.previous = self
                } else {
                    setAutomatically = true
                }
            }
        }
        
        public weak var previous: LinkedListNode<T>? {
            didSet {
                if setAutomatically {
                    previous?.setAutomatically = false
                    previous?.next = self
                } else {
                    setAutomatically = true
                }
            }
        }
        
        public init(value: T) {
            self.value = value
        }
        
    }
    
}


//MARK: Computed Properties
public extension LinkedList {
    var head: Element? {
        return headNode?.value
    }
    var tail: Element? {
        return tailNode?.value
    }
    
    var first: Element? {
        return head
    }
    
    var last: Element? {
        return tail
    }
    
    
}

//MARK: - Sequence Conformance
extension LinkedList: Sequence {
    
    public typealias Iterator = LinkedListIterator<Element>
    
    public __consuming func makeIterator() -> LinkedList<Element>.Iterator {
        return LinkedListIterator(node: headNode)
    }
    
    public struct LinkedListIterator<T>: IteratorProtocol {
        
        public typealias Element = T
        
        private var currentNode: LinkedListNode<T>?
        
        fileprivate init(node: LinkedListNode<T>?) {
            currentNode = node
        }
        
        public mutating func next() -> T? {
            guard let node = currentNode else {
                return nil
            }
            currentNode = node.next
            return node.value
        }
        
    }
}

//MARK: Collection Conformance
extension LinkedList: Collection {
    
    public typealias Index = LinkedListIndex<Element>
    
    public var startIndex: LinkedList<Element>.Index {
        return LinkedListIndex(node: headNode, offset: 0)
    }
    
    public var endIndex: LinkedList<Element>.Index {
        return LinkedListIndex(node: tailNode, offset: count)
    }
    
    public func index(after i: LinkedList<Element>.LinkedListIndex<Element>) -> LinkedList<Element>.LinkedListIndex<Element> {
        precondition(i.offset != endIndex.offset, "Linked List index is out of bounds")
        return Index(node: i.node?.next, offset: i.offset + 1)
    }
    
    public struct LinkedListIndex<T>: Comparable {
        fileprivate var node: LinkedList<T>.LinkedListNode<T>?
        fileprivate var offset: Int
        
        fileprivate init(node: LinkedList<T>.Node<T>?, offset: Int) {
            self.node = node
            self.offset = offset
        }
        
        public static func ==<T>(lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
            return lhs.offset == rhs.offset
        }
        
        public static func < <T>(lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
            return lhs.offset < rhs.offset
        }
    }
    
    
    
    
}


//MARK: - MutableCollection Conformance
extension LinkedList: MutableCollection {
    
    public subscript(position: LinkedList<Element>.LinkedListIndex<Element>) -> Element {
        get {
            precondition(position.offset != endIndex.offset, "Index out of range")
            return position.node!.value
        }
        set {
            precondition(position.offset != endIndex.offset, "Index out of range")
            position.node!.value = newValue
        }
    }
    
    private func node(at index: LinkedList<Element>.LinkedListIndex<Element>) -> LinkedListNode<Element>? {
        precondition(index.offset != endIndex.offset, "Index out of range")
        return index.node
    }
    
}


public extension LinkedList {
    private mutating func append(node: LinkedListNode<Element>) {
        defer { count += 1 }
        guard !isEmpty else {
            headNode = node
            tailNode = node
            return
        }
        tailNode?.next = node
        tailNode = node
    }
    
    mutating func append(_ newElement: Element) {
        append(node: LinkedListNode(value: newElement))
    }
    
    mutating func append(_ linkedList: LinkedList) {
        guard !linkedList.isEmpty else { return }
        defer { count += linkedList.count }
        guard !isEmpty else {
            headNode = linkedList.headNode
            tailNode = linkedList.tailNode
            return
        }
        tailNode?.next = linkedList.headNode
        tailNode = linkedList.tailNode
    }
    
    private mutating func prepend(node: LinkedListNode<Element>) {
        defer { count += 1 }
        guard !isEmpty else {
            headNode = node
            tailNode = node
            return
        }
        headNode?.previous = node
        headNode = node
    }
    
    mutating func prepend(_ newElement: Element) {
        prepend(node: LinkedListNode(value: newElement))
    }
    
    mutating func prepend(_ linkedList: LinkedList) {
        guard !linkedList.isEmpty else { return }
        defer { count += linkedList.count }
        guard !isEmpty else {
            headNode = linkedList.headNode
            tailNode = linkedList.tailNode
            return
        }
        linkedList.tailNode?.next = headNode
        headNode = linkedList.headNode
    }
    
    private mutating func popFirstNode() -> LinkedListNode<Element>? {
        guard let head = headNode else {
            return nil
        }
        count -= 1
        count -= 1
        if count == 1 {
            headNode = nil
            tailNode = nil
        } else {
            headNode = head.next
        }
        return head
    }
    
    mutating func popFirst() -> Element? {
        return popFirstNode()?.value
    }
    
    private mutating func popLastNode() -> LinkedListNode<Element>? {
        guard let tail = tailNode else {
            return nil
        }
        count -= 1
        if count == 1 {
            headNode = nil
            tailNode = nil
        } else {
            tailNode = tail.previous
        }
        return tail
    }
    
    mutating func popLast() -> Element? {
        return popLastNode()?.value
    }
}

//MARK: - RandomAccessCollection Conformance
extension LinkedList: RandomAccessCollection {
    
}

//MARK: - BidirectionalCollection Conformance
extension LinkedList: BidirectionalCollection {
    public func index(before i: LinkedList<Element>.LinkedListIndex<Element>) -> LinkedList<Element>.LinkedListIndex<Element> {
        precondition(i.offset != startIndex.offset, "Linked List index is out of bounds")
        return Index(node: i.node?.previous, offset: i.offset - 1)
    }
    
}

//MARK: - BidirectionalCollection Conformance
extension LinkedList: RangeReplaceableCollection {
    public mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: __owned C) where C : Collection, R : RangeExpression, LinkedList.Element == C.Element, LinkedList.Index == R.Bound {
        
        let range = subrange.relative(to: self)
        precondition(range.lowerBound >= startIndex && range.upperBound <= endIndex, "Replacement subrange bounds are out of range")
        
        guard !(range.lowerBound == startIndex && range.upperBound == endIndex) else {
            if let linkedList = newElements as? LinkedList<Element> {
                self = linkedList
            } else {
                self = LinkedList(newElements)
            }
            return
        }
        
        guard range.lowerBound != self.endIndex else {
            if let linkedList = newElements as? LinkedList<Element> {
                append(linkedList)
            } else {
                newElements.forEach { append($0) }
            }
            return
        }
        
        guard range.upperBound != self.startIndex else {
            if let linkedList = newElements as? LinkedList<Element> {
                prepend(linkedList)
            } else {
                newElements.forEach { prepend($0) }
            }
            return
        }
        
        guard !newElements.isEmpty else {
            if range.lowerBound == startIndex {
                headNode = node(at: range.upperBound)
                headNode?.previous = nil
            } else if range.upperBound == endIndex {
                tailNode = node(at: index(before: range.lowerBound))
                tailNode?.previous = nil
            } else {
                node(at: index(before: range.lowerBound))?.next =  node(at: range.upperBound)
            }
            return
        }
        
        let linkedList: LinkedList<Element>
        if newElements is LinkedList<Element> {
            linkedList = newElements as! LinkedList<Element>
        } else {
            linkedList = LinkedList(newElements)
        }
        
        count += linkedList.count - (range.upperBound.offset - range.lowerBound.offset)
        if range.lowerBound == startIndex {
            node(at: range.upperBound)?.previous = linkedList.tailNode
            headNode = linkedList.headNode
        } else if range.upperBound == endIndex {
            node(at: index(before: range.lowerBound))?.next = linkedList.headNode
            tailNode = linkedList.headNode
        } else {
            node(at: index(before: range.lowerBound))?.next = linkedList.headNode
            node(at: range.upperBound)?.previous = linkedList.tailNode
        }
        
    }
}

//MARK: ExpressibleByArrayLiteral Conformance
extension LinkedList: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Element
    
    public init(arrayLiteral elements: LinkedList<Element>.ArrayLiteralElement...) {
        self.init(elements)
    }
    
    public init<T>(_ sequence: T) where T: Sequence, T.Element == Element {
        if let linkedList = sequence as? LinkedList<Element> {
            headNode = linkedList.headNode
            tailNode = linkedList.tailNode
            count = linkedList.count
        } else {
            for element in sequence {
                append(element)
            }
        }
    }
    
}

//MARK: CustomStringConvertible Conformance
extension LinkedList: CustomStringConvertible {
    public var description: String {
        return "[" + lazy.map { "\($0)" }.joined(separator: ", ") + "]"
    }
}


var list1 = LinkedList<String>()

list1.append("Hello")
list1.append("World")
list1.append("It's")
list1.append("Jai")
//        print(list1)

var list2 = LinkedList<String>()
list2.append("Whatsapp")
list2.append("facebook")

list1.append(list2)


list2.append("Snapchat")
print(list2)

