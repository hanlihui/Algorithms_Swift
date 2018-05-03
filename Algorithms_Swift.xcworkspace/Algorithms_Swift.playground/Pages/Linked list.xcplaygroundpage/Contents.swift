/*:
 # Linked list
 --------------
 链表由一系列不必在内存中相连的结构组成。每一个结构均含有表元素和指向包含该元素后继元的结构的指针。我们称之为Next指针。最后一个单元的Next指针指向Null。
 ## 1. 插入节点
    a. 头部插入
    b. 尾部插入
    c. 指定位置插入
 ## 2. 删除节点
    a. 头部删除
    b. 尾部删除
    c. 指定位置删除
 ## 3. copy-on-write
 在Swift中，所有的基本类型，包括整数、浮点数、字符串、数组和字典等都是值类型，并且都以结构体的形式实现。这些值类型每次赋值传递都是会重新在内存里拷贝一份吗？答案是否定的，只有当这个值需要改变时才进行复制行为。
 ## Code Example
 
 */

// 创建节点
example(of: "creating and linking nodes") {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    node1.next = node2
    node2.next = node3
    print(node1)
}

// MARK: - add node
// push
example(of: "push") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print(list)
}

// append
example(of: "append") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    
    print(list)
}

// insert
example(of: "inserting at a particular index") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before inserting:", list)
    
    var middleNode = list.node(at: 1)!
    for _ in 1...4 {
        middleNode = list.insert(-1, after: middleNode)
    }
    
    print("after inserting: \(list)")
}

// MARK: - remove node

// pop
example(of: "pop") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before popping list:", list)
    let popValue = list.pop()
    print("after popping list: \(list)")
    print("popped value:" + String(describing: popValue))
}

// removeLast
example(of: "removeLast") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before remoing last node:", list)
    let removedValue = list.removeLast()
    print("after remoing last node: \(list)")
    print("removed value:" + String(describing: removedValue))
}


// removing a node after a particular node
example(of: "removing a node after a particular node") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before removing at particular index:", list)
    let index = 1
    let node = list.node(at: index - 1)!
    let removedValue = list.remove(after: node)
    
    print("after removing at index \(index): \(list)")
    print("removed value:" + String(describing: removedValue))
}


// MARK: - using collection
example(of: "using collection") {
    var list = LinkedList<Int>()
    for i in 0...9 {
        list.append(i)
    }
    print("List:\(list)")
    print("First element:\(list[list.startIndex])")
    print("Array containing first 3 elements: \(Array(list.prefix(3)))")
    print("Array containing last 3 elements: \(Array(list.suffix(3)))")
    
    let sum = list.reduce(0, +)
    print("sum of all values:\(sum)")
    
}

// MARK: - copy-on-write
example(of: "linked list cow") {
    var list1 = LinkedList<Int>()
    list1.append(1)
    list1.append(2)
    
    var list2 = list1
    
    print("list1:\(list1)")
    print("list2:\(list2)")
    
    print("after appending 3 to list2")
    list2.append(3)
    
    print("list1:\(list1)")
    print("list2:\(list2)")
}













