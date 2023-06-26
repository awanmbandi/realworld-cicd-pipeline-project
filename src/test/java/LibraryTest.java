import org.testng.annotations.Test;

import static org.testng.Assert.*;

public class LibraryTest {
  @Test
  public void testSomeLibraryMethod() {
    Library classUnderTest = new Library();
    assertTrue(classUnderTest.someLibraryMethod(), "someLibraryMethod should return 'true'");
  }
}
