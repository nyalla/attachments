import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

public class ParallelProcessing
{
    public static void main(String argss[]) throws InterruptedException {


        List<CompletableFuture<Integer>> futuresList = new ArrayList<CompletableFuture<Integer>>();

        CompletableFuture<Integer> addAsy = CompletableFuture.supplyAsync(()->(addFun1(10,5)));
        CompletableFuture<Integer> subAsy = CompletableFuture.supplyAsync(()->(subFun1(10,5)));
        CompletableFuture<Integer> mulAsy = CompletableFuture.supplyAsync(()->(mulFun1(10,5)));

        futuresList.add(addAsy);
        futuresList.add(subAsy);
        futuresList.add(mulAsy);

        CompletableFuture<Void> allFutures = CompletableFuture
                .allOf(futuresList.toArray(new CompletableFuture[futuresList.size()]));

        CompletableFuture<List<Integer>> allCompletableFuture = allFutures.thenApply(future -> {
            return futuresList.stream().map(completableFuture -> completableFuture.join())
                    .collect(Collectors.toList());
        });

        CompletableFuture<List<Integer>> completableFuture = allCompletableFuture.toCompletableFuture();

        try {
            List<Integer> finalList = (List<Integer>) completableFuture.get();
            System.out.print(finalList);
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
    }



    public static  Integer  addFun1(int a, int b) {
        System.out.println(Thread.currentThread().getName());
        for (int i=0;i<10;i++){
            System.out.print(Thread.currentThread().getName()+i);
        }
        return  a+b ;
    }

    public static  Integer  subFun1(int a, int b) {
        System.out.println(Thread.currentThread().getName());
        for (int i=0;i<10;i++){
            System.out.print(Thread.currentThread().getName()+i);
        }
        return  a-b ;
    }

    public static  Integer  mulFun1(int a, int b) {
        System.out.println(Thread.currentThread().getName());
        for (int i=0;i<10;i++){
            System.out.print(Thread.currentThread().getName()+i);
        }
        return  a*b ;
    }
}
