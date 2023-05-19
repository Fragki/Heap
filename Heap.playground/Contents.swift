import UIKit

class Heap<T: Equatable> {
    private var nodes: [T] = []
    private let compare: (T, T) -> Bool
    
    public init(_ compare: @escaping (T, T) -> Bool) {
        self.compare = compare
    }
    
    public var isEmpty: Bool {
        nodes.isEmpty
    }
    
    public var count: Int {
        nodes.count
    }
    
    public var peek: T? {
        nodes.first
    }
    
    public func insert(node: T) {
        nodes.append(node)
        heapifyUp(nodes.count - 1)
    }
    
    public func remove(node: T) -> T? {
        guard let first = nodes.first else { return nil }
        guard nodes.count > 1 else { return nodes.removeLast() }
        
        nodes[0] = nodes.removeLast()
        heapifyDown(0)
        return first
    }
    
    
    private func heapifyUp(_ index: Int) {
        var currentIndex = index
        while currentIndex > 0 {
            let parentIndex = parentIndex(ofIndex: currentIndex)
            if compare(nodes[currentIndex], nodes[parentIndex]) {
                nodes.swapAt(currentIndex, parentIndex)
                currentIndex = parentIndex
            } else {
                break
            }
        }
    }
    
    private func heapifyDown(_ index: Int) {
        var currentIndex = index
        var firstChildIndex = currentIndex
        while currentIndex < nodes.count {
            let leftChildIndex = leftChildIndex(ofIndex: currentIndex)
            let rightChildIndex = rightChildIndex(ofIndex: currentIndex)

            if leftChildIndex < nodes.count && compare(nodes[leftChildIndex], nodes[firstChildIndex]) {
                firstChildIndex = leftChildIndex
            }
            if rightChildIndex < nodes.count && compare(nodes[rightChildIndex], nodes[firstChildIndex]) {
                firstChildIndex = rightChildIndex
            }
            if currentIndex != firstChildIndex {
                nodes.swapAt(currentIndex, firstChildIndex)
                currentIndex = firstChildIndex
            } else {
                break
            }
        }
    }
}

extension Heap {
    func parentIndex(ofIndex i: Int) -> Int {
      return (i - 1) / 2
    }

    func leftChildIndex(ofIndex i: Int) -> Int {
      return 2 * i + 1
    }
    
    func rightChildIndex(ofIndex i: Int) -> Int {
      return 2 * i + 2
    }
}

//Complexities
// Insert O(logn)
// Remove O(logn)
// Search O(n)
// Find peek O(1)

var heap = Heap<Int>(>)
heap.insert(node: 3)
heap.peek
heap.insert(node: 5)
heap.peek
heap.insert(node: 2)
heap.peek
heap.insert(node: 6)
heap.peek
heap.insert(node: 4)
heap.peek
heap.remove(node: 6)
heap.peek
