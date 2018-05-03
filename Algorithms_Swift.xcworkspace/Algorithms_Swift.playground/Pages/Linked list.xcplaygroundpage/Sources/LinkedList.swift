
public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    // MARK: - Adding values to the list
    // 1. push: Adds a value at the front of the list.
    public mutating func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    // 2. append: Adds a value at the end of the list.
    public mutating func append(_ value: Value) {
        copyNodes()
        // if the list is empty ,you`ll need to update both head and tail to the new node.
        guard !isEmpty else {
            push(value)
            return
        }
        tail!.next = Node(value:value)
        tail = tail!.next
    }
    
    // 3. insert: Adds a value after a particular node of the list.
    
    // finding a particular node in the list
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    // MARK: - removing values from the list
    // 1. pop: removes the value at the front of the list
    @discardableResult
    public mutating func pop() -> Value? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    // 2. removeLast: removes the value at the end of the list
    @discardableResult
    public mutating func removeLast() -> Value? {
        copyNodes()
        // if head is nil ,there`s nothing to remove
        guard let head = head else {
            return nil
        }
        // if the list only consists of one node,removeLast is functionally equivalent to pop
        guard head.next != nil else {
            return pop()
        }
        // if the current.next is nil ,this signifies that current is the last node of the list
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        return current.value
    }
    // 3. remove(at:): removes a value anywhere in the list
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        copyNodes()
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    // MARK: - copy-on-write
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else {
            return
        }
        guard var oldNode = head else {
            return
        }
        head = Node(value: oldNode.value)
        var newNode = head
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            oldNode = nextOldNode
        }
        tail = newNode
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

extension LinkedList: Collection {
    public struct Index : Comparable {
        public var node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch(lhs.node, rhs.node) {
                case let(left?, right?):
                    return left.next === right.next
                case (nil, nil):
                    return true
                default:
                    return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) {
                $0?.next
            }
            return nodes.contains { $0 === rhs.node }
        }
        
    }
    
    public var startIndex: Index {
        return Index(node: head)
    }
    
    public var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
}
