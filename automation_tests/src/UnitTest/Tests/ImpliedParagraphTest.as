////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package UnitTest.Tests
{
    import UnitTest.ExtendedClasses.TestConfigurationLoader;
    import UnitTest.ExtendedClasses.VellumTestCase;
    import UnitTest.Fixtures.TestCaseVo;
    import UnitTest.Fixtures.TestConfig;

    import flashx.textLayout.conversion.ConversionType;
    import flashx.textLayout.conversion.ITextExporter;
    import flashx.textLayout.conversion.ITextImporter;
    import flashx.textLayout.conversion.TextConverter;
    import flashx.textLayout.elements.TextFlow;

    import org.flexunit.asserts.assertTrue;

    [TestCase(order=26)]
    [RunWith("org.flexunit.runners.Parameterized")]
    public class ImpliedParagraphTest extends VellumTestCase
    {
        private const inputString1:String = '<i>Italic</i> Plain <i>Italic</i> Plain <b>Bold</b>';
        private const inputString2:String = '<b>Bold</b> <i>Italic</i> Plain <i>Italic</i> Plain <b>Bold</b>';
        private const inputString3:String = '<i><b>BoldItalic</b></i> Plain <i>Italic</i> Plain <b>Bold</b>';
        private const inputString4:String = '<textformat leading="200%"><i><b>BoldItalic</b></i> </textformat>Plain <i>Italic</i> Plain <b>Bold</b>';
        private const inputString5:String = '<p>asdf</p><b>bold</b><i>italic</i><p>qwerty</p>';
        private const inputString6:String = 'Plain <b>Bold</b> <i>Italic</i> Plain <i>Italic</i> Plain <b>Bold</b>';
        private const outputString1:String = '<p><span fontStyle="italic">Italic</span><span> Plain </span><span fontStyle="italic">Italic</span><span> Plain </span><span fontWeight="bold">Bold</span></p>';
        private const outputString2:String = '<p><span fontWeight="bold">Bold</span><span> </span><span fontStyle="italic">Italic</span><span> Plain </span><span fontStyle="italic">Italic</span><span> Plain </span><span fontWeight="bold">Bold</span></p>';
        private const outputString3:String = '<p><span fontStyle="italic" fontWeight="bold">BoldItalic</span><span> Plain </span><span fontStyle="italic">Italic</span><span> Plain </span><span fontWeight="bold">Bold</span></p>';
        private const outputString4:String = '<p leadingModel="approximateTextField" lineHeight="200%"><span fontStyle="italic" fontWeight="bold">BoldItalic</span><span> Plain </span><span fontStyle="italic">Italic</span><span> Plain </span><span fontWeight="bold">Bold</span></p>';
        private const outputString5:String = '<p><span>asdf</span></p><p><span fontWeight="bold">bold</span><span fontStyle="italic">italic</span></p><p><span>qwerty</span></p>';
        private const outputString6:String = '<p><span>Plain </span><span fontWeight="bold">Bold</span><span> </span><span fontStyle="italic">Italic</span><span> Plain </span><span fontStyle="italic">Italic</span><span> Plain </span><span fontWeight="bold">Bold</span></p>';

        [DataPoints(loader=impliedParagraphHTMLImportTest1Loader)]
        [ArrayElementType("UnitTest.Fixtures.TestCaseVo")]
        public static var impliedParagraphHTMLImportTest1Dp:Array;

        public static var impliedParagraphHTMLImportTest1Loader:TestConfigurationLoader = new TestConfigurationLoader("../../test/testCases/ImpliedParagraphTest.xml", "impliedParagraphHTMLImportTest1");

        private var textImporter:ITextImporter = TextConverter.getImporter(TextConverter.TEXT_FIELD_HTML_FORMAT);
        private var textExporter:ITextExporter = TextConverter.getExporter(TextConverter.TEXT_LAYOUT_FORMAT);

        public function ImpliedParagraphTest()
        {
            super("", "ImpliedParagraphTest", TestConfig.getInstance());

            metaData = {};
        }

        [After]
        public override function tearDownTest():void
        {
            // Restore default configurations
            super.tearDownTest();
        }

        [Test(dataProvider=impliedParagraphHTMLImportTest1Dp)]
        public function impliedParagraphHTMLImportTest1(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            runTheTest(inputString1, outputString1);
        }

        [Test(dataProvider=impliedParagraphHTMLImportTest1Dp)]
        public function impliedParagraphHTMLImportTest2(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            runTheTest(inputString2, outputString2);
        }

        [Test(dataProvider=impliedParagraphHTMLImportTest1Dp)]
        public function impliedParagraphHTMLImportTest3(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            runTheTest(inputString3, outputString3);
        }

        [Test(dataProvider=impliedParagraphHTMLImportTest1Dp)]
        public function impliedParagraphHTMLImportTest4(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            runTheTest(inputString4, outputString4);
        }

        [Test(dataProvider=impliedParagraphHTMLImportTest1Dp)]
        public function impliedParagraphHTMLImportTest5(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            runTheTest(inputString5, outputString5);
        }

        [Test(dataProvider=impliedParagraphHTMLImportTest1Dp)]
        public function impliedParagraphHTMLImportTest6(testCaseVo:TestCaseVo):void
        {
            TestData.fileName = testCaseVo.fileName;
            super.setUpTest();

            runTheTest(inputString6, outputString6);
        }

        private function runTheTest(inString:String, outString:String):void
        {
            var textFlow:TextFlow = textImporter.importToFlow(inString);
            var markupResult:String = textExporter.export(textFlow, ConversionType.STRING_TYPE) as String;
            var startIndex:int = markupResult.search("<p");
            var endIndex:int = markupResult.search("</TextFlow>");
            var expectedString:String = markupResult.substring(startIndex, endIndex);
            assertTrue("TLF model did not match expected result", expectedString == outString);
        }
    }
}
