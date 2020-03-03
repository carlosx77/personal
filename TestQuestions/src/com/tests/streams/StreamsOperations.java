package com.tests.streams;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.function.Predicate;
import java.util.stream.Collector;
import java.util.stream.Collectors;
import static java.util.stream.Collectors.*;

//import static java.util.stream.Collectors;

import java.io.IOException;;

public class StreamsOperations {
	
	public enum CaloricLevel { DIET, NORMAL, FAT };
	
	public static void main(String... args) {
		new StreamsOperations().execute();
	}

	private List<Dish> getMenu() {
		List<Dish> menu = Arrays.asList(new Dish("pork", false, 800, Dish.Type.MEAT),
				new Dish("beef", false, 700, Dish.Type.MEAT), new Dish("chicken", false, 400, Dish.Type.MEAT),
				new Dish("french fries", false, 530, Dish.Type.OTHER), new Dish("rice", true, 350, Dish.Type.OTHER),
				new Dish("season fruit", true, 120, Dish.Type.OTHER), new Dish("pizza", true, 550, Dish.Type.OTHER),
				new Dish("prawns", false, 300, Dish.Type.FISH), new Dish("salmon", false, 450, Dish.Type.FISH));
		return menu;
	}

	private void execute() {
		List<String> simpleList = Arrays.asList(new String[] { "D", "B", "C", "A" });

		// Limit
		List<String> limitedList = simpleList.stream().limit(2).collect(Collectors.toList());
		System.out.println("\nLimited One: ");
		limitedList.forEach(System.out::println);

		// Sorted
		List<String> orderedLimitedList = simpleList.stream().sorted().limit(2).collect(Collectors.toList());
		System.out.println("Ordered and limited One: ");
		orderedLimitedList.forEach(System.out::println);

		// Skip elements
		System.out.println("Skipping");
		simpleList.stream().skip(2).forEach(System.out::println);

		// Distinct
		List<String> repeatedElementsList = Arrays.asList(new String[] { "A", "A", "C", "A" });
		List<String> nonRepeated = repeatedElementsList.stream().distinct().collect(Collectors.toList());
		System.out.println("Non repeated");
		nonRepeated.forEach(System.out::println);

		// Map, map gets information from other elements
		List<String> namesList = this.getMenu().stream().map(Dish::getName).collect(Collectors.toList());
		System.out.println("Show names list");
		namesList.forEach(System.out::println);

		List<Integer> dishNameLengths = this.getMenu().stream().map(Dish::getName).map(String::length)
				.collect(toList());
		System.out.println("Show Name Length");
		dishNameLengths.forEach(System.out::println);

		// iterating over list of lists or double array elements to combine them!!!
		List<Dish> dishes1 = this.getMenu();
		List<Dish> dishes2 = this.getMenu();
		List<String[]> mixedDishes = dishes1.stream()
				.flatMap(i -> dishes2.stream().map(z -> new String[] { i.getName(), z.getName() })).collect(toList());
		System.out.println("Mixed");
		mixedDishes.stream().forEach(i -> {
			System.out.println(i[0] + " " + i[1]);
		});

		// now with 3 inner map/flatmap
		List<Dish> dishes3 = this.getMenu();
		List<String[]> mixedDishes2 = dishes1.stream()
				.flatMap(
					i -> dishes2
					.stream()
					.flatMap(
							z -> dishes3
							.stream()
							.map(
								y -> new String[] { i.getName(), z.getName(), y.getName() }
							)
						)).collect(toList());
		System.out.println("3 Mixed!!!");
		mixedDishes2.stream().forEach(i -> {
			System.out.println(i[0] + " " + i[1] + " " + i[2]);
		});
		
		if (dishes1.stream().anyMatch(Dish::isVegetarian)) {
			System.out.println("Has vegetarian dishes");
		}
		
		if ( dishes1.stream()
                .allMatch(d -> d.getCalories() < 1000 )) {
			System.out.println("Is Healthy");
		} else {
			System.out.println("May not be healthy");	
		}
		
		Optional<Dish> anyVeggyDish = dishes1.stream().filter(Dish::isVegetarian).findAny();
		if ( anyVeggyDish.isPresent() ) {
			System.out.println("We have a veggyDish: " + anyVeggyDish.get().getName() );
		}
		
		Optional<Dish> nullDish = dishes1.stream().filter(Dish::isFalse).findAny();
		System.out.println("Is empty: " + nullDish.isEmpty());
		System.out.println("Is isPresent: " + nullDish.isPresent());
		
		List<Integer> integers = Arrays.asList(new Integer[] {1, 2, 3, 4, 5});
		System.out.println("Suma: " + integers.stream().reduce(0, (a,b) -> a + b ));
		
		System.out.println("Maximun " + integers.stream().reduce(Integer::max).get());
		System.out.println("Minimun " + integers.stream().reduce(Integer::min).get());
		//(x,y)->x<y?x:y
		System.out.println("Minimun with lambda " + integers.stream().reduce((x,y)->x<y?x:y).get());
		
		//Counting
		System.out.println("Counting elements " + integers.stream().map(d->1).reduce(0, (a,b)->a+b));
		System.out.println("Counting elements2 " + integers.stream().count() );
		
		
		Trader raoul = new Trader("Raoul", "Cambridge");
		Trader mario = new Trader("Mario","Milan");
		Trader alan = new Trader("Alan","Cambridge");
		Trader brian = new Trader("Brian","Cambridge");

		List<Transaction> transactions = Arrays.asList(
		    new Transaction(brian, 2011, 300),
		    new Transaction(raoul, 2012, 1000),
		    new Transaction(raoul, 2011, 400),
		    new Transaction(mario, 2012, 710),
		    new Transaction(mario, 2012, 700),
		    new Transaction(alan, 2012, 950)
		);
		//Find all transactions in 2011 and sort by value (small to high)
		transactions.stream()
				.filter(transaction->transaction.getYear() == 2011)
				.sorted((a,b) ->Integer.compare(a.getValue(), b.getValue())) //interchange values
				//to order desc, in this way is in asc
				.collect(toList()).forEach(a->System.out.println("Valor" + a.getValue()));
		
		transactions.stream()
		.map(trans->trans.getTrader().getCity()).distinct().collect(Collectors.toList()).forEach(System.out::println);
		//Find all traders from Cambridge and sort them by name.
		transactions.stream()
		.filter(t->t.getTrader().getCity().equals("Cambridge"))
		.distinct()
		.sorted((a, b)-> a.getTrader().getName().compareTo(b.getTrader().getName())).collect(Collectors.toList()).forEach(System.out::println);
		//What are all the unique cities where the traders work?
		transactions.stream()
		.map(d->d.getTrader().getCity())
		.distinct().collect(Collectors.toList()).forEach(System.out::println);
		//Return a string of all traders’ names sorted alphabetically
		transactions.stream()
		.map(d->d.getTrader().getName())
		.distinct()
		.sorted()
		.collect(Collectors.toList()).forEach(System.out::println);
		System.out.println("Are any traders based in Milan?");
		boolean result = transactions.stream()
		.map(transaction->transaction.getTrader().getCity())
		.anyMatch(city->city.equals("Milan"));
		System.out.println(result);
		System.out.println("Are any traders based in Milan? simplified");
		boolean result1 = transactions.stream()
				.anyMatch(transaction->transaction.getTrader().getCity().equals("Milan"));
		System.out.println(result1);
		//Print all transactions’ values from the traders living in Cambridge
		System.out.println("Print all transactions’ values from the traders living in Cambridge");
		transactions.stream()
		.filter(transaction->transaction.getTrader().getCity().equals("Cambridge"))
		.map(Transaction::getValue).forEach(System.out::println);
		System.out.println("What’s the highest value of all the transactions?");
		Transaction transaction = transactions.stream()
		.max((a,b)->Integer.compare(a.getValue(), b.getValue())).get();
		System.out.println(transaction);
		System.out.println("What’s the highest value of all the transactions? Other way");
		Optional<Integer> max = transactions.stream().map(Transaction::getValue).reduce(Integer::max);
		System.out.println(max);
		System.out.println("Find the transaction with the smallest value");
		Optional<Transaction> min = transactions.stream().reduce((t1, t2)->t1.getValue()<t2.getValue()?t1:t2);
		System.out.println(min);
		
		System.out.println("Grouping by city");
		Map<String, List<Transaction>> groupedByCity =
		transactions.stream().collect(Collectors.groupingBy(t->t.getTrader().getCity()));
		groupedByCity.entrySet().forEach(
			t-> {
				System.out.println ("Key " + t.getKey() );
				t.getValue().stream().forEach(System.out::println);
			});
		
		
		
		Map<CaloricLevel, List<Dish>> groupedByCalories =
				this.getMenu().stream().collect(Collectors.groupingBy(
						dish -> {
							if ( dish.getCalories() <= 400 )
								return CaloricLevel.DIET;
							else if ( dish.getCalories() <= 700 )
								return CaloricLevel.NORMAL;
							return CaloricLevel.FAT;
						}
						));
				groupedByCity.entrySet().forEach(
					t-> {
						System.out.println ("Key " + t.getKey() );
						t.getValue().stream().forEach(System.out::println);
					});
		System.out.println("Caloric Levels: " + groupedByCalories);
		
		System.out.println("Multilevel grouping ");
		Map<Dish.Type, Map<CaloricLevel, List<Dish>>> multiGrouped =
				this.getMenu().stream().collect(Collectors.groupingBy(Dish::getType,Collectors.groupingBy(
						dish -> {
							if ( dish.getCalories() <= 400 )
								return CaloricLevel.DIET;
							else if ( dish.getCalories() <= 700 )
								return CaloricLevel.NORMAL;
							return CaloricLevel.FAT;
						}
						)));
				groupedByCity.entrySet().forEach(
					t-> {
						System.out.println ("Key " + t.getKey() );
						t.getValue().stream().forEach(System.out::println);
					});
		System.out.println("Multigrouped: " + multiGrouped);
		
		System.out.println("Counting.. " + transactions.stream().collect(Collectors.counting()));
		System.out.println("Counting.. " + transactions.stream().count());
		
		Optional<Dish> maxCaloriesDish = this.getMenu().stream().collect(Collectors.maxBy(Comparator.comparingInt(Dish::getCalories)));
		System.out.println(maxCaloriesDish.get());
		
		System.out.println("Sumarizing, averaging");
		System.out.println(this.getMenu().stream().collect(Collectors.summarizingInt(Dish::getCalories)));
		System.out.println(this.getMenu().stream().collect(Collectors.averagingDouble(Dish::getCalories)));

		System.out.println("Joining strings");
		System.out.println(this.getMenu().stream().map(Dish::getName)
				.collect(Collectors.joining(", ")));
		
		Map<Dish.Type, Long> typesCount = this.getMenu().stream()
				.collect(Collectors.groupingBy(Dish::getType, Collectors.counting()));
		System.out.println( "Counting by group " + typesCount );

	}
}
