import static org.testng.AssertJUnit.assertTrue;

import org.testng.annotations.Test;

/**
 * The TestNGTest does little more than prove TestNG is working for both unit and integration tests.
 */
public class TestNGTest {
  @Test
  public void notIntegrationTest() {
    assertTrue(true);
  }

  @Test(groups = { "integration" })
  public void integrationTest() {
    assertTrue(true);
  }

}
