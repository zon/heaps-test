package common;

import polygonal.ds.Heap;
import common.Grid;
import common.GridNode;

class Pathfinder {
	public var grid: Grid;

	public function new(grid) {
		this.grid = grid;
	}

	public function travel(start: GridNode, goal: GridNode): Array<GridNode> {
		if (goal.solid) return [];
		
		var criteria = function(n: GridNode) {
			return n == goal;
		};

		var heuristic = function(n: GridNode) {
			return Math.floor(Math.abs(goal.x - n.x) + Math.abs(goal.y - n.y));
		};

		return query(start, criteria, heuristic);
	}

	function query(
		start: GridNode,
		criteria: (n: GridNode) -> Bool,
		heuristic: (n: GridNode) -> Int
	) {
		var frontier = new Heap<GridNode>();
		var origins = new Map<Int, GridNode>();
		var costs = new Map<Int, Int>();

		start.heuristic = 0;
		frontier.add(start);
		costs[index(start)] = 0;

		var current: GridNode = null;
		for (_ in 0...1000) {
			current = frontier.pop();
			if (current == null) {
				return null;
			}
			
			if (criteria(current)) {
				return createPath(origins, current);
			}

			var neighbors = new Array<GridNode>();
			var x = current.x;
			var y = current.y;
			getPush(neighbors, x - 1, y);
			getPush(neighbors, x + 1, y);
			getPush(neighbors, x, y - 1);
			getPush(neighbors, x, y + 1);

			var baseCost = costs[index(current)];
			for (next in neighbors) {
				var nextCost = baseCost + 1;
				var prevCost = costs[index(next)];
				if (prevCost == null || nextCost < prevCost) {
					var ph = next.heuristic;
					next.heuristic = nextCost + heuristic(next);
					if (prevCost != null) {
						frontier.change(next, ph - next.heuristic);
					} else {
						frontier.add(next);
					}
					origins[index(next)] = current;
					costs[index(next)] = nextCost;
				}
			}
		}

		return createPath(origins, current);
	}

	function createPath(origins: Map<Int, GridNode>, last: GridNode) {
		var path = new Array<GridNode>();
		path.push(last);
		var current = last;
		while (current != null) {
			current = origins[index(current)];
			if (current != null) {
				path.push(current);
			}
		}
		path.reverse();
		return path;
	}

	function index(node: GridNode) {
		return grid.index(node); 
	}

	function getPush(arr: Array<GridNode>, x, y) {
		var node = grid.get(x, y);
		if (node != null && !node.solid)  {
			arr.push(node);
		}
	}

}
