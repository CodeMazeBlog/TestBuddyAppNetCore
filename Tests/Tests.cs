using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Tests
{
	[TestClass]
	public class Tests
	{
		[TestMethod]
		public void ResultIsFalseNot()
		{
			Assert.IsFalse(true);
		}

		[TestMethod]
		public void ResultIsFalse()
		{
			Assert.IsFalse(false);
		}
	}
}
