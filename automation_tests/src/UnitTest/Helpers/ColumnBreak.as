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
package UnitTest.Helpers
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    [SWF(width="1200", height="400")]

    public class ColumnBreak extends Sprite
    {
        public var textFlow:TextFlow = new TextFlow();

        public function ColumnBreak(columnWidth:int, textLayoutFmt1:TextLayoutFormat, textLayoutFmt2:TextLayoutFormat, textLayoutFmt3:TextLayoutFormat)
        {
            /*
             TextFlow.hostFormat        -> textLayoutFormat
             DivElement.format          -> autoFmt
             ListElement.format         -> alwaysFmt
             ListItemElement123.format  -> inheritFmt
             ParagraphElement123.format -> inheritFmt

             TextFlow.addController -> Sprite123(container123)

             TextFlow -> ListElement -> ListItemElement123 -> ParagraphElement123 -> span123 -> string123
             */

            var para1String:String = "STR1CBB " + textLayoutFmt1.columnBreakBefore
                    + "CBA " + textLayoutFmt1.columnBreakAfter;
            var para2String:String = "STR2CBB " + textLayoutFmt2.columnBreakBefore
                    + "CBA " + textLayoutFmt2.columnBreakAfter;
            var para3String:String = "STR3CBB " + textLayoutFmt3.columnBreakBefore
                    + "CBA " + textLayoutFmt3.columnBreakAfter;


            var listElement:ListElement = new ListElement();
            var listItemElement1:ListItemElement = new ListItemElement();
            var listItemElement2:ListItemElement = new ListItemElement();
            var listItemElement3:ListItemElement = new ListItemElement();

            var paragraph1:ParagraphElement = new ParagraphElement();
            var paragraph2:ParagraphElement = new ParagraphElement();
            var paragraph3:ParagraphElement = new ParagraphElement();

            var spanElement:SpanElement = new SpanElement();
            spanElement.text = para1String;
            paragraph1.addChild(spanElement);

            spanElement = new SpanElement();
            spanElement.text = para2String;
            paragraph2.addChild(spanElement);

            spanElement = new SpanElement();
            spanElement.text = para3String;
            paragraph3.addChild(spanElement);


            listItemElement1.addChild(paragraph1);
            listItemElement2.addChild(paragraph2);
            listItemElement3.addChild(paragraph3);
            listElement.addChild(listItemElement1);
            listElement.addChild(listItemElement2);
            listElement.addChild(listItemElement3);

            textFlow.addChild(listElement);

            var textLayoutFormat:TextLayoutFormat = new TextLayoutFormat();
            textLayoutFormat.fontSize = 12;
            textLayoutFormat.textIndent = 10;
            textLayoutFormat.paragraphSpaceAfter = 5;
            textLayoutFormat.columnCount = 3;
            textLayoutFormat.fontFamily = "Arial";
            textFlow.hostFormat = textLayoutFormat;

            paragraph1.format = textLayoutFmt1;
            paragraph2.format = textLayoutFmt2;
            paragraph3.format = textLayoutFmt3;

            if (stage)
            {
                stage.align = StageAlign.TOP_LEFT;
                stage.scaleMode = StageScaleMode.NO_SCALE;
            }

            var sprite1:Sprite = new Sprite();
            var sprite2:Sprite = new Sprite();
            var sprite3:Sprite = new Sprite();

            addChild(sprite1);

            textFlow.flowComposer.addController(new ContainerController(sprite1, columnWidth, columnWidth));
            sprite1.graphics.beginFill(0xf0f0a0);
            sprite1.graphics.drawRect(0, 0, columnWidth, columnWidth);
            sprite1.graphics.endFill();
            sprite1.x = 0;
            sprite1.y = 0;

            textFlow.flowComposer.updateAllControllers();

        }

    }
}